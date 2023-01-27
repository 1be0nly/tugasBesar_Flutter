import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_besar_flutter/apiServices/apiService.dart';
import 'package:tugas_besar_flutter/dataModel/modelClass.dart';
import 'listdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class AddData extends StatefulWidget {
  final modelClass;
  final int? index;
  AddData({this.index, this.modelClass});
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController judulController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController tahunController = TextEditingController();
  TextEditingController blokController = TextEditingController();

  bool editMode = false;

  tambahBuku(modelClass classModel) async {
    await apiService().addBuku(classModel);
  }

  ubahBuku(modelClass classModel) async {
    await apiService().updateBuku(classModel);
  }

  void error(BuildContext context, String error) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(error),
        action: SnackBarAction(
            label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      editMode = true;
      judulController.text = widget.modelClass.judul;
      penulisController.text = widget.modelClass.penulis;
      tahunController.text = widget.modelClass.tahun;
      blokController.text = widget.modelClass.blok;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          editMode ? "AzmoBook - Ubah Buku" : "AzmoBook - Tambah Buku",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: judulController,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Judul",
                      hintStyle: TextStyle(fontFamily: "Poppins"),
                      labelText: "Judul",
                      labelStyle: TextStyle(fontFamily: "Poppins")),
                ),
                new TextField(
                  controller: penulisController,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Penulis",
                      hintStyle: TextStyle(fontFamily: "Poppins"),
                      labelText: "Penulis"),
                ),
                new TextField(
                  controller: tahunController,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  decoration: new InputDecoration(
                      hintText: "Tahun", labelText: "Tahun"),
                ),
                new TextField(
                  controller: blokController,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  decoration:
                      new InputDecoration(hintText: "Blok", labelText: "Blok"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent),
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return Home();
                          }));
                        },
                        child: new Text(
                          "Kembali",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.pinkAccent),
                        onPressed: () {
                          if (editMode) {
                            modelClass classModel = modelClass(
                                id: widget.modelClass.id,
                                judul: judulController.text,
                                penulis: penulisController.text,
                                tahun: tahunController.text,
                                blok: blokController.text);
                            ubahBuku(classModel);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                          } else {
                            if (judulController.value.text.isEmpty) {
                              setState(() {
                                error(context, "Isi judul buku!");
                              });
                            } else if (penulisController.value.text.isEmpty) {
                              setState(() {
                                error(context, "Isi nama penulis!");
                              });
                            } else if (tahunController.value.text
                                    .contains(RegExp(r'[a-zA-Z]')) ||
                                tahunController.value.text.isEmpty) {
                              setState(() {
                                error(context, "Tahun harus berisi angka!");
                                error(context, "Isi tahun buku!");
                              });
                            } else if (blokController.value.text.isEmpty) {
                              setState(() {
                                error(context, "Isi blok rak buku!");
                              });
                            } else {
                              modelClass classModel = modelClass(
                                  id: '',
                                  judul: judulController.text,
                                  penulis: penulisController.text,
                                  tahun: tahunController.text,
                                  blok: blokController.text);
                              tambahBuku(classModel);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Home();
                              }));
                            }
                          }
                        },
                        child: new Text(
                          editMode ? "Ubah Buku" : "Tambah Buku",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
