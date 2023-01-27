import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'listdata.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AzmoBOOK",
              style: TextStyle(
                  fontFamily: "Poppins", fontWeight: FontWeight.bold)),
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Image(image: AssetImage("assets/dashboard.png")),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: double.infinity,
                child: Text(
                  "Selamat datang, Pustakawan!",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Lihat Data",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
