import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';
import 'package:tugas_besar_flutter/apiServices/apiService.dart';
import 'package:tugas_besar_flutter/dataModel/modelClass.dart';
import 'add_editdata.dart';
import 'homepage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  RandomColor _randomColor = RandomColor();

  late List<modelClass> dataList;
  bool loading = true;

  tampilData() async {
    dataList = await apiService().getBuku();
    setState(() {
      loading = false;
    });
  }

  hapusData(modelClass ClassModel) async {
    await apiService().deleteBuku(ClassModel);
    setState(() {
      loading = false;
      tampilData();
    });
    Fluttertoast.showToast(
      msg: "Buku berhasil dihapus",
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void initState() {
    super.initState();
    tampilData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          "AzmoBOOK - List Buku",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            heroTag: "Tambah Buku",
            onPressed: () {
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => new AddData()));
            },
            label: const Text('Tambah Buku'),
            icon: const Icon(Icons.add_box),
            backgroundColor: Colors.greenAccent,
          ),
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: dataList.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                modelClass model = dataList[index];
                return Card(
                  color: _randomColor.randomColor(colorHue: ColorHue.blue),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new AddData(
                            modelClass: model,
                            index: index,
                          ),
                        ),
                      );
                    },
                    leading: Icon(Icons.collections_bookmark_sharp,
                        color: Colors.white),
                    title: Text("Judul Buku : " + model.judul,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.all(4)),
                        Text(
                          "Penulis Buku : " + model.penulis,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Tahun Buku : " + model.tahun,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "Blok Rak : " + model.blok,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    trailing: IconButton(
                      iconSize: 30,
                      icon: Icon(
                        Icons.delete_sharp,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        hapusData(model);
                      },
                    ),
                  ),
                );
              }),
    );
  }
}
