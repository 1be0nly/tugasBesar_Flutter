class modelClass {
  String id;
  String judul;
  String penulis;
  String tahun;
  String blok;

  modelClass(
      {required this.id,
      required this.judul,
      required this.penulis,
      required this.tahun,
      required this.blok});

  factory modelClass.fromJson(Map<String, dynamic> json) {
    return modelClass(
        id: json['id'] as String,
        judul: json['judul'] as String,
        penulis: json['penulis'] as String,
        tahun: json['tahun'] as String,
        blok: json['blok'] as String);
  }

  Map<String, dynamic> toJsonAdd() {
    return {"judul": judul, "penulis": penulis, "tahun": tahun, "blok": blok};
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "id": id,
      "judul": judul,
      "penulis": penulis,
      "tahun": tahun,
      "blok": blok
    };
  }
}
