import 'package:flutter/material.dart';
import 'database_helper.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  List<Map<String, dynamic>> data = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadResume();
  }

  Future<void> loadResume() async {
    final result = await DatabaseHelper.ambilResume();
    setState(() {
      data = result;
      loading = false;
    });
  }

  // Fungsi pembantu untuk mencocokkan cover berdasarkan judul buku secara otomatis
  String dapatkanCoverBuku(String judul) {
    switch (judul) {
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
        return 'assets/cover/default.jpeg'; // Sampul cadangan jika judul tak dikenal
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Koleksi Resume",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu_book_rounded, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        "Belum ada resume yang ditulis",
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    final String pathCover = dapatkanCoverBuku(item['judul_buku']);

                    // Format tanggal sederhana mengambil komponen YYYY-MM-DD
                    String tglFormat = item['tanggal'] != null 
                        ? item['tanggal'].toString().split(' ')[0] 
                        : '-';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 14),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailResumePage(
                                judul: item['judul_buku'],
                                isi: item['isi_resume'],
                                tanggal: tglFormat,
                                coverPath: pathCover,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Menampilkan Gambar Sampul Buku
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  pathCover,
                                  width: 65,
                                  height: 95,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 65,
                                      height: 95,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.book, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Konten Info Judul dan Potongan Resume
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item['judul_buku'],
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          tglFormat,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item['isi_resume'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class DetailResumePage extends StatelessWidget {
  final String judul;
  final String isi;
  final String tanggal;
  final String coverPath;

  const DetailResumePage({
    super.key,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.coverPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Catatan", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sektor Header Detail (Sampul Buku + Metadata Kanan)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    coverPath,
                    width: 100,
                    height: 145,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      const Text(
                        "Judul Buku",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        judul,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Tanggal Tulis",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        tanggal,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Divider(thickness: 1),
            ),
            // Blok Konten Resume Utama
            const Text(
              "Isi Ringkasan atau Resume:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              isi,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}