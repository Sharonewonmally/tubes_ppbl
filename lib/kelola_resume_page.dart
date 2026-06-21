import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'detail_resume_admin_page.dart';

class KelolaResumePage extends StatefulWidget {
  const KelolaResumePage({super.key});

  @override
  State<KelolaResumePage> createState() => _KelolaResumePageState();
}

class _KelolaResumePageState extends State<KelolaResumePage> {
  List<Map<String, dynamic>> data = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await DatabaseHelper.ambilResume();
    setState(() {
      data = result;
      loading = false;
    });
  }

  Future<void> hapusResume(int id) async {
    await DatabaseHelper.deleteResume(id);
    loadData();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Resume berhasil dihapus 🗑️"),
      ),
    );
  }

  // Fungsi pembantu otomatisasi deteksi aset gambar cover buku
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
        return 'assets/cover/default.jpeg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Kelola Resume Pengguna",
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
                      Icon(Icons.folder_open_rounded, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        "Belum ada data resume masuk",
                        style: TextStyle(color: Colors.grey[600], fontSize: 15),
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
                    String tglFormat = item['tanggal'] != null 
                        ? item['tanggal'].toString().split(' ')[0] 
                        : '-';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
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
                              builder: (_) => DetailResumeAdminPage(
                                judul: item['judul_buku'],
                                isi: item['isi_resume'],
                                tanggal: tglFormat,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Gambar Sampul Buku
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  pathCover,
                                  width: 60,
                                  height: 85,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    width: 60,
                                    height: 85,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.book, color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Info Text Metadata Resume
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['judul_buku'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Dibuat: $tglFormat",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      item['isi_resume'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              // Aksi Delete Admin
                              IconButton(
                                icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
                                onPressed: () {
                                  // Munculkan dialog konfirmasi demi keamanan data admin
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Hapus Resume"),
                                      content: const Text("Apakah Anda yakin ingin menghapus catatan resume ini permanen dari sistem?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Batal"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            hapusResume(item['id']);
                                          },
                                          child: const Text("Hapus", style: TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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