import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tugas_besar_flutter/dataModel/modelClass.dart';

class apiService {
  List<modelClass> bukuFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<modelClass>.from(data.map((item) => modelClass.fromJson(item)));
  }

  Future<List<modelClass>> getBuku() async {
    final response =
        await http.get(Uri.parse("http://192.168.69.82/AzmoBook/list.php"));

    if (response.statusCode == 200) {
      List<modelClass> body = bukuFromJson(response.body);
      return body;
    } else {
      return <modelClass>[];
    }
  }

  Future<String> addBuku(modelClass classModel) async {
    final response = await http.post(
        Uri.parse("http://192.168.69.82/AzmoBook/create.php"),
        body: classModel.toJsonAdd());
    if (response.statusCode == 200) {
      print("Add Response: " + response.body);
      return response.body;
    } else {
      throw Exception('Gagal menambahkan buku');
    }
  }

  Future<String> updateBuku(modelClass classModel) async {
    final response = await http.post(
        Uri.parse("http://192.168.69.82/AzmoBook/update.php"),
        body: classModel.toJsonUpdate());
    if (response.statusCode == 200) {
      print("Update Response: " + response.body);
      return response.body;
    } else {
      throw Exception('Gagal mengubah buku');
    }
  }

  Future<String> deleteBuku(modelClass classModel) async {
    final response = await http.post(
        Uri.parse("http://192.168.69.82/AzmoBook/delete.php"),
        body: classModel.toJsonUpdate());
    if (response.statusCode == 200) {
      print("Delete Response: " + response.body);
      return response.body;
    } else {
      throw Exception('Gagal menghapus buku');
    }
  }
}
