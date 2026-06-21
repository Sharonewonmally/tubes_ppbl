import 'package:flutter/material.dart';
import 'database_helper.dart';
import '../widgets/riwayat_card.dart';

class RiwayatBacaPage extends StatefulWidget {
  const RiwayatBacaPage({super.key});

  @override
  State<RiwayatBacaPage> createState() => _RiwayatBacaPageState();
}

class _RiwayatBacaPageState extends State<RiwayatBacaPage> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await DatabaseHelper.ambilRiwayatBaca();

    print("DATA RIWAYAT:");
    print(result);

    setState(() {
      data = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Latar belakang soft
      appBar: AppBar(
        title: const Text(
          "Riwayat Baca",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          // Membatasi lebar agar tetap proporsional di layar lebar (PC/Web)
          constraints: const BoxConstraints(maxWidth: 600),
          child: data.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 80,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Belum ada riwayat membaca",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];

                    // MEMANGGIL CUSTOM WIDGET MANDIRI DI SINI
                    return RiwayatCard(
                      judul: item['judul'] ?? 'Judul Tidak Diketahui',
                      tanggal: item['tanggal'] ?? '',
                      imagePath: item['image'],
                    );
                  },
                ),
        ),
      ),
    );
  }
}