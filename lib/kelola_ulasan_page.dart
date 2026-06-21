import 'package:flutter/material.dart';
import 'database_helper.dart';

class KelolaUlasanPage extends StatefulWidget {
  const KelolaUlasanPage({super.key});

  @override
  State<KelolaUlasanPage> createState() =>
      _KelolaUlasanPageState();
}

class _KelolaUlasanPageState
    extends State<KelolaUlasanPage> {

  List<Map<String,dynamic>> ulasanList = [];

  @override
  void initState() {
    super.initState();
    loadUlasan();
  }

  Future<void> loadUlasan() async {

    final data =
    await DatabaseHelper.getUlasan();

    setState(() {
      ulasanList = data;
    });
  }

  Future<void> hapus(int id) async {

    await DatabaseHelper.deleteUlasan(id);

    loadUlasan();
  }
  void lihatUlasan(
    Map<String,dynamic> data) {

  showDialog(
    context: context,
    builder: (_) {

      return AlertDialog(
        title: Text(
          data['judul_buku'],
        ),

        content: Text(
          data['komentar'],
        ),
      );
    },
  );
}
void editUlasan(
    Map<String,dynamic> data) {

  final komentarC =
      TextEditingController(
    text: data['komentar'],
  );

  showDialog(
    context: context,
    builder: (_) {

      return AlertDialog(

        title: const Text(
          "Edit Ulasan",
        ),

        content: TextField(
          controller: komentarC,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: "Komentar",
          ),
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Batal",
            ),
          ),

          ElevatedButton(
            onPressed: () async {

              await DatabaseHelper.updateUlasan(
                data['id'],
                data['rating'],
                komentarC.text,
              );

              Navigator.pop(context);

              loadUlasan();
            },
            child: const Text(
              "Update",
            ),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Kelola Ulasan",
        ),
        backgroundColor: Colors.blue,
      ),

      body: ulasanList.isEmpty

          ? const Center(
        child: Text(
          "Belum ada ulasan",
        ),
      )

          : ListView.builder(

        itemCount: ulasanList.length,

        itemBuilder: (context,index){

          final data =
          ulasanList[index];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ListTile(

              leading: CircleAvatar(
                backgroundColor:
                Colors.amber,
                child: Text(
                  data['rating']
                      .toString(),
                ),
              ),

              title: Text(
                data['judul_buku'],
              ),

              subtitle: Text(
                data['komentar'],
              ),

             trailing: Row(
  mainAxisSize: MainAxisSize.min,
  children: [

    IconButton(
      icon: const Icon(
        Icons.visibility,
        color: Colors.blue,
      ),
      onPressed: () {
        lihatUlasan(data);
      },
    ),

    IconButton(
      icon: const Icon(
        Icons.edit,
        color: Colors.orange,
      ),
      onPressed: () {
        editUlasan(data);
      },
    ),

    IconButton(
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        hapus(data['id']);
      },
    ),
  ],
),
            ),
          );
        },
      ),
    );
  }
}