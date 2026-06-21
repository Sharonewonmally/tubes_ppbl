import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class KelolaPromosiPage extends StatefulWidget {
  const KelolaPromosiPage({super.key});

  @override
  State<KelolaPromosiPage> createState() =>
      _KelolaPromosiPageState();
}

class _KelolaPromosiPageState
    extends State<KelolaPromosiPage> {

  List<Map<String,dynamic>> promosiList = [];

  File? selectedImage;

  final ImagePicker picker =
  ImagePicker();


  @override
  void initState() {
    super.initState();
    getPromosi();
  }

  Future<void> getPromosi() async {

    final data =
    await DatabaseHelper.getPromosi();

    setState(() {

      promosiList = data;
    });
  }

  Future<void> hapusPromosi(
      int id,
      ) async {

    final db =
    await DatabaseHelper.getDatabase();

    await db.delete(
      'promosi',
      where: 'id=?',
      whereArgs: [id],
    );

    getPromosi();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title:
        const Text(
            'Kelola Promosi'),

        backgroundColor:
        Colors.blue,
      ),

      floatingActionButton:
      FloatingActionButton(

        backgroundColor:
        Colors.blue,

        child:
        const Icon(Icons.add),

        onPressed: () {

          showTambahDialog();
        },
      ),

      body: ListView.builder(

        itemCount:
        promosiList.length,

        itemBuilder:
            (context,index){

          final data =
          promosiList[index];

          return Card(

            margin:
            const EdgeInsets.all(10),

            child: ListTile(

              leading:
              const Icon(
                  Icons.campaign),

              title:
              Text(
                  data['judul']),

              subtitle:
              Text(
                  data['tanggal']),

              trailing:
              Row(

                mainAxisSize:
                MainAxisSize.min,

                children: [

                  IconButton(

                    icon:
                    const Icon(
                        Icons.edit),

                    onPressed: () {

                      showEditDialog(
                          data);
                    },
                  ),

                  IconButton(

                    icon:
                    const Icon(
                        Icons.delete),

                    onPressed: () {

                      hapusPromosi(
                          data['id']);
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
  // =====================
  // TAMBAH GAMBAR
  // =====================
  Future<void> pickImage() async {

    final XFile? image =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {

        selectedImage =
            File(image.path);
      });
    }
  }
  // =====================
  // TAMBAH
  // =====================

  void showTambahDialog() {

    final judulC =
    TextEditingController();

    final isiC =
    TextEditingController();

    String tanggal =
    DateFormat(
      'dd MMMM yyyy',
    ).format(
      DateTime.now(),
    );

    String gambarPath = "";
    gambarPath = "";

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            'Tambah Promosi',
          ),

          content:
          StatefulBuilder(

            builder:
                (context,setDialogState){

              return SingleChildScrollView(

                child: Column(

                  mainAxisSize:
                  MainAxisSize.min,

                  children: [

                    TextField(
                      controller: judulC,

                      decoration:
                      const InputDecoration(
                        labelText:
                        "Judul Promosi",
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller: isiC,

                      maxLines: 4,

                      decoration:
                      const InputDecoration(
                        labelText:
                        "Isi Promosi",
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    ElevatedButton.icon(

                      onPressed: () async {

                        final picker =
                        ImagePicker();

                        final XFile? image =
                        await picker.pickImage(
                          source:
                          ImageSource.gallery,
                        );

                        if(image != null){

                          setDialogState(() {

                            gambarPath =
                                image.path;
                          });
                        }
                      },

                      icon:
                      const Icon(
                        Icons.image,
                      ),

                      label:
                      const Text(
                        "Pilih Gambar",
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    if(gambarPath.isNotEmpty)

                      Text(
                        gambarPath,
                        maxLines: 2,
                      ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Tanggal : $tanggal",
                    ),
                  ],
                ),
              );
            },
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child:
              const Text(
                "Batal",
              ),
            ),

            ElevatedButton(

              onPressed: () async {

                final db =
                await DatabaseHelper
                    .getDatabase();

                await db.insert(

                  'promosi',

                  {

                    'judul':
                    judulC.text,

                    'isi':
                    isiC.text,

                    'gambar':
                    gambarPath,

                    'tanggal':
                    tanggal,
                  },
                );

                Navigator.pop(
                  context,
                );

                getPromosi();
              },

              child:
              const Text(
                "Simpan",
              ),
            ),
          ],
        );
      },
    );
  }

  // =====================
  // EDIT
  // =====================

  void showEditDialog(
      Map<String,dynamic> data
      ) {

    final judulC =
    TextEditingController(
      text:data['judul'],
    );

    final isiC =
    TextEditingController(
      text:data['isi'],
    );

    String gambarPath =
        data['gambar'] ?? "";

    final tanggalC =
    TextEditingController(
      text:data['tanggal'],
    );

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title:
          const Text(
              'Edit Promosi'),

          content:
          SingleChildScrollView(

            child: Column(

              children: [
                ElevatedButton.icon(
                  onPressed: () async {

                    final XFile? image =
                    await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if(image != null){

                      gambarPath =
                          image.path;
                    }
                  },

                  icon: const Icon(Icons.image),

                  label: const Text(
                    "Ganti Gambar",
                  ),
                ),

                TextField(
                  controller:
                  judulC,
                ),


                TextField(
                  controller:
                  isiC,
                ),


                TextField(
                  controller:
                  tanggalC,
                ),
              ],
            ),
          ),

          actions: [

            TextButton(

              onPressed:
                  () async {

                    await DatabaseHelper.updatePromosi(
                      data['id'],
                      judulC.text,
                      isiC.text,
                      gambarPath,
                      tanggalC.text,
                    );
                Navigator.pop(
                    context);

                getPromosi();
              },

              child:
              const Text(
                  'Update'),
            ),
          ],
        );
      },
    );
  }
}