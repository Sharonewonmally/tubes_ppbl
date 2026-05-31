import 'package:flutter/material.dart';
import 'database_helper.dart';

class DetailForumPage extends StatefulWidget {

  final Map forum;

  const DetailForumPage({
    super.key,
    required this.forum,
  });

  @override
  State<DetailForumPage> createState() =>
      _DetailForumPageState();
}

class _DetailForumPageState
    extends State<DetailForumPage> {

  final komentarC =
  TextEditingController();

  List komentarList = [];

  @override
  void initState() {
    super.initState();
    getKomentar();
  }

  // =====================
  // AMBIL KOMENTAR
  // =====================
  Future<void> getKomentar() async {

    final db =
    await DatabaseHelper.getDatabase();

    komentarList =
    await db.query(
      'komentar',
      where: 'forum_id = ?',
      whereArgs: [
        widget.forum['id'],
      ],
    );

    setState(() {});
  }

  // =====================
  // KIRIM KOMENTAR
  // =====================
  Future<void> kirimKomentar() async {

    if (komentarC.text.isEmpty) {
      return;
    }

    try {

      final db =
      await DatabaseHelper.getDatabase();

      await db.insert(
        'komentar',
        {
          'forum_id':
          widget.forum['id'],
          'pesan':
          komentarC.text,
        },
      );

      komentarC.clear();

      getKomentar();

    } catch (e) {

      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xffEAF4FF),

      appBar: AppBar(

        title:
        const Text(
            'Detail Forum'),

        backgroundColor:
        Colors.blue,
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding:
          const EdgeInsets.all(16),

          child: Column(

            children: [

              Container(

                width:
                double.infinity,

                padding:
                const EdgeInsets.all(
                    16),

                decoration:
                BoxDecoration(

                  color:
                  Colors.white,

                  borderRadius:
                  BorderRadius
                      .circular(
                      20),
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [

                    Text(

                      widget.forum[
                      'judul'],

                      style:
                      const TextStyle(

                        fontSize:
                        20,

                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      widget.forum[
                      'isi'],
                    ),

                    const SizedBox(
                        height: 10),

                    Text(

                      'Genre: ${widget.forum['genre']}',

                      style:
                      const TextStyle(
                        color:
                        Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 20),

              TextField(

                controller:
                komentarC,

                decoration:
                InputDecoration(

                  hintText:
                  'Tulis komentar...',

                  filled:
                  true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius
                        .circular(
                        14),
                  ),
                ),
              ),

              const SizedBox(
                  height: 14),

              SizedBox(

                width:
                double.infinity,

                height: 50,

                child:
                ElevatedButton(

                  onPressed:
                  kirimKomentar,

                  style:
                  ElevatedButton
                      .styleFrom(

                    backgroundColor:
                    Colors.blue,
                  ),

                  child:
                  const Text(

                    'Kirim Komentar',

                    style:
                    TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  height: 20),

              const Align(

                alignment:
                Alignment
                    .centerLeft,

                child: Text(

                  'Diskusi',

                  style: TextStyle(

                    fontSize:
                    18,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ),

              const SizedBox(
                  height: 12),

              ListView.builder(

                shrinkWrap:
                true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount:
                komentarList
                    .length,

                itemBuilder:
                    (context,
                    index) {

                  final komentar =
                  komentarList[
                  index];

                  return Container(

                    width:
                    double.infinity,

                    margin:
                    const EdgeInsets.only(
                        bottom:
                        12),

                    padding:
                    const EdgeInsets.all(
                        14),

                    decoration:
                    BoxDecoration(

                      color:
                      Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                          16),
                    ),

                    child: Text(
                      komentar[
                      'pesan'],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}