import 'package:flutter/material.dart';
import 'database_helper.dart';

// ==================== [CUSTOM WIDGET FOR COVER] ====================
class BookCoverWidget extends StatelessWidget {
  final String image;

  const BookCoverWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        image,
        width: 45,
        height: 60,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.book, size: 40),
      ),
    );
  }
}

// ==================== [MAIN ADMIN PAGE] ====================
class RiwayatBacaAdminPage extends StatefulWidget {
  const RiwayatBacaAdminPage({super.key});

  @override
  State<RiwayatBacaAdminPage> createState() => _RiwayatBacaAdminPageState();
}

class _RiwayatBacaAdminPageState extends State<RiwayatBacaAdminPage> {
  List<Map<String, dynamic>> data = [];

  // Pilihan buku yang tersedia di aplikasi Safae untuk mempermudah Admin (Create/Update)
  final List<Map<String, String>> daftarBukuTersedia = [
    {"judul": "Bumi", "image": "assets/cover/bumi.jpeg"},
    {"judul": "Bendera Setengah Tiang", "image": "assets/cover/BST.jpeg"},
    {"judul": "Hujan", "image": "assets/cover/hujan.jpeg"},
    {"judul": "Laut Bercerita", "image": "assets/cover/LB.jpeg"},
    {"judul": "KKN di Desa Penari", "image": "assets/cover/kkn.jpeg"},
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ==================== [READ] ====================
  Future<void> loadData() async {
    final result = await DatabaseHelper.ambilRiwayatBaca();
    setState(() {
      data = result;
    });
  }

  // ==================== [CREATE] ====================
  void tampilkanFormTambah() {
    String? bukuTerpilih = daftarBukuTersedia.first['judul'];
    String? imageTerpilih = daftarBukuTersedia.first['image'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Tambah Riwayat Baca"),
              content: DropdownButtonFormField<String>(
                value: bukuTerpilih,
                decoration: const InputDecoration(labelText: "Pilih Buku"),
                items: daftarBukuTersedia.map((buku) {
                  return DropdownMenuItem<String>(
                    value: buku['judul'],
                    child: Text(buku['judul']!),
                  );
                }).toList(),
                onChanged: (val) {
                  setDialogState(() {
                    bukuTerpilih = val;
                    imageTerpilih = daftarBukuTersedia.firstWhere((b) => b['judul'] == val)['image'];
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (bukuTerpilih != null && imageTerpilih != null) {
                      await DatabaseHelper.tambahRiwayatBaca(
                        bukuTerpilih!,
                      
                      );
                      Navigator.pop(context);
                      loadData();
                      tampilkanSnackbar("Riwayat berhasil ditambahkan ✨");
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==================== [UPDATE] ====================
  void tampilkanFormEdit(Map<String, dynamic> item) {
    // Cari index buku saat ini agar Dropdown tidak error crash
    String? bukuTerpilih = daftarBukuTersedia.any((b) => b['judul'] == item['judul'])
        ? item['judul']
        : daftarBukuTersedia.first['judul'];
    
    String? imageTerpilih = daftarBukuTersedia.firstWhere((b) => b['judul'] == bukuTerpilih)['image'];
    final TextEditingController tanggalController = TextEditingController(
      text: item['tanggal'].toString().split(' ')[0], // Ambil YYYY-MM-DD saja
    );

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Edit Riwayat Baca"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: bukuTerpilih,
                    decoration: const InputDecoration(labelText: "Ubah Buku"),
                    items: daftarBukuTersedia.map((buku) {
                      return DropdownMenuItem<String>(
                        value: buku['judul'],
                        child: Text(buku['judul']!),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setDialogState(() {
                        bukuTerpilih = val;
                        imageTerpilih = daftarBukuTersedia.firstWhere((b) => b['judul'] == val)['image'];
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: tanggalController,
                    decoration: const InputDecoration(
                      labelText: "Tanggal Baca (YYYY-MM-DD)",
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setDialogState(() {
                          tanggalController.text = pickedDate.toString().split(' ')[0];
                        });
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // MENGGUNAKAN FUNGSI CLEAN DARI DATABASE HELPER
                    await DatabaseHelper.updateRiwayatBaca(
                      item['id'],
                      bukuTerpilih!,
                      imageTerpilih!,
                      "${tanggalController.text} 00:00:00.000",
                    );
                    Navigator.pop(context);
                    loadData();
                    tampilkanSnackbar("Riwayat berhasil diperbarui 📝");
                  },
                  child: const Text("Ubah"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==================== [DELETE] ====================
  Future<void> hapusRiwayat(int id) async {
    await DatabaseHelper.hapusRiwayatBaca(id);
    loadData();
    tampilkanSnackbar("Riwayat berhasil dihapus 🗑️");
  }

  void tampilkanSnackbar(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Kelola Riwayat Baca",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: data.isEmpty
          ? const Center(
              child: Text(
                "Belum ada data riwayat membaca",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                String tglFormat = item['tanggal'] != null 
                    ? item['tanggal'].toString().split(' ')[0] 
                    : '-';

                return GestureDetector(
                  onDoubleTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Buku: ${item['judul']}"),
                      ),
                    );
                  },
                  onLongPress: () {
                    tampilkanFormEdit(item);
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      // Memanggil widget BookCoverWidget
                      leading: item['image'] != null && item['image'].toString().isNotEmpty
                          ? BookCoverWidget(image: item['image'])
                          : const Icon(Icons.book, size: 40),
                      title: Text(
                        item['judul'] ?? 'Tanpa Judul',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "Dibaca: $tglFormat",
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tombol UPDATE
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => tampilkanFormEdit(item),
                          ),
                          // Tombol DELETE
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => hapusRiwayat(item['id']),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      // Tombol CREATE
      floatingActionButton: FloatingActionButton(
        onPressed: tampilkanFormTambah,
        tooltip: "Tambah Riwayat",
        child: const Icon(Icons.add),
      ),
    );
  }
}