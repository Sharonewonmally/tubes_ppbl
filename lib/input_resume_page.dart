import 'package:flutter/material.dart';
import 'database_helper.dart';

class InputResumePage extends StatefulWidget {
  final String judulBuku;

  const InputResumePage({
    super.key,
    required this.judulBuku,
  });

  @override
  State<InputResumePage> createState() => _InputResumePageState();
}

class _InputResumePageState extends State<InputResumePage> {
  final TextEditingController resumeController = TextEditingController();

  // FUNGSI SIMPAN DATABASE
  Future<void> simpanResume() async {
    final teksResume = resumeController.text.trim();

    // Validasi jika inputan kosong
    if (teksResume.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Resume tidak boleh kosong!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    try {
      // 1. Panggil fungsi dari DatabaseHelper
      await DatabaseHelper.tambahResume(
        widget.judulBuku,
        teksResume,
      );

      // 2. Tampilkan pesan sukses jika berhasil
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Resume berhasil disimpan ke database"),
          ),
        );
        
        // 3. Kembali ke halaman utama bacaan
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal menyimpan resume: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    resumeController.dispose(); // Membersihkan controller saat halaman ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Menambah latar belakang soft agar efek Card lebih kelihatan
      appBar: AppBar(
        title: const Text("Isi Resume"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Resume Buku",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Buku: ${widget.judulBuku}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: resumeController,
                  maxLines: 12,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Tuliskan ringkasan atau resume buku yang telah dibaca...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: simpanResume,
                    child: const Text(
                      "Simpan Resume",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}