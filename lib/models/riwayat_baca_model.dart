class RiwayatBaca {
  int? id;
  String judul;
  String tanggal;

  RiwayatBaca({
    this.id,
    required this.judul,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'tanggal': tanggal,
    };
  }

  factory RiwayatBaca.fromMap(
      Map<String, dynamic> map) {
    return RiwayatBaca(
      id: map['id'],
      judul: map['judul'],
      tanggal: map['tanggal'],
    );
  }
}