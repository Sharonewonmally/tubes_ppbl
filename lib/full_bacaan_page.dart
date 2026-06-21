  import 'package:flutter/material.dart';

  import 'database_helper.dart';
  import 'komentar_page.dart';
  import 'ulasan_page.dart';
  import 'input_resume_page.dart';

  class FullBacaanPage extends StatefulWidget {
    final String title;

    const FullBacaanPage({
      super.key,
      required this.title,
    });

    @override
    State<FullBacaanPage> createState() => _FullBacaanPageState();
  }

  class _FullBacaanPageState extends State<FullBacaanPage> {


    String content = "";
    bool loading = true;

    @override
    void initState() {
      super.initState();
      loadContent();
    }

    Future<void> loadContent() async {

    await DatabaseHelper.tambahRiwayatBaca(
      widget.title,
    );

    final db =
        await DatabaseHelper.getDatabase();

    // cek buku bawaan
var result = await db.query(
  'book_contents',
  where: 'title=?',
  whereArgs: [widget.title],
);


// kalau tidak ada di buku bawaan
// cek buku user
if(result.isEmpty){

  result = await db.query(
    'buku_user',
    where: 'judul=?',
    whereArgs: [widget.title],
  );


  if(result.isNotEmpty){

    content = result.first['isi']
        .toString();

  }

}

else{

  content = result.first['content']
      .toString();

}

    setState(() {
      loading = false;
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )

            : Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [

                    Expanded(
                      child: Card(
                        elevation: 4,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(16),
                        ),

                        child: Padding(
                          padding:
                              const EdgeInsets.all(20),

                          child: SingleChildScrollView(
                            child: Text(
                              content,

                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.7,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height:20),

                    SizedBox(
                      width:220,
                      height:55,

                      child: ElevatedButton.icon(

                        onPressed:(){

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:(_)=>
                              const KomentarPage(),
                            ),
                          );

                        },

                        icon: const Icon(
                          Icons.comment,
                        ),

                        label: const Text(
                          "Tambah Komentar",

                          style: TextStyle(
                            fontSize:16,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        style:
                        ElevatedButton.styleFrom(

                          elevation:5,

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),

                        ),

                      ),
                    ),

                  const SizedBox(height:15),

  Row(
    children: [

      Expanded(
        child: SizedBox(
          height: 55,

          child: ElevatedButton.icon(

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UlasanPage(
                    title: widget.title,
                  ),
                ),
              );

            },

            icon: const Icon(Icons.star),

            label: const Text(
              "Ulasan",
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),

      const SizedBox(width: 10),

      Expanded(
        child: SizedBox(
          height: 55,

          child: ElevatedButton.icon(

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InputResumePage(
                    judulBuku: widget.title,
                  ),
                ),
              );

            },

            icon: const Icon(Icons.edit_note),

            label: const Text(
              "Resume",
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,

              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
  const SizedBox(height:15),
                    const SizedBox(height:15),

                    

                  ],
                ),
              ),
      );
    }
  }