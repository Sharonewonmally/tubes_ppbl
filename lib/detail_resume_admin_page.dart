import 'package:flutter/material.dart';

class DetailResumeAdminPage extends StatelessWidget {
  final String judul;
  final String isi;
  final String tanggal;

  const DetailResumeAdminPage({
    super.key,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  // Fungsi pembantu untuk mencocokkan cover berdasarkan judul buku
  String dapatkanCoverBuku(String judulBuku) {
    switch (judulBuku) {
      case 'Bumi':
        return 'assets/cover/bumi.jpeg';
      case 'Bendera Setengah Tiang':
        return 'assets/cover/BST.jpeg';
      case 'Hujan':
        return 'assets/cover/hujan.jpeg';
      case 'Laut Bercerita':
        return 'assets/cover/LB.jpeg';
      case 'KKN di Desa Penari':
        return 'assets/cover/kkn.jpeg';
      default:
        return 'assets/cover/default.jpeg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String pathCover = dapatkanCoverBuku(judul);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Detail Catatan Pengguna",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sektor Informasi Buku & Sampul (Header)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    pathCover,
                    width: 100,
                    height: 145,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) => Container(
                      width: 100,
                      height: 145,
                      color: Colors.grey[200],
                      child: const Icon(Icons.book, size: 40, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Buku Terkait",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        judul,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.calendar_today_rounded, size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 6),
                          Text(
                            "Diserahkan: $tanggal",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Divider(thickness: 1, color: Color(0xFFEEEEEE)),
            ),

            // Sektor Blok Konten Catatan Resume
            const Text(
              "Hasil Catatan Ringkasan",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEFEFEF)),
              ),
              child: Text(
                isi,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}