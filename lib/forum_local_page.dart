import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'list_forum_page.dart';

class ForumLocalPage extends StatefulWidget {
  const ForumLocalPage({super.key});

  @override
  State<ForumLocalPage> createState() =>
      _ForumLocalPageState();
}

class _ForumLocalPageState
    extends State<ForumLocalPage> {


  final judulC =
  TextEditingController();

  final isiC =
  TextEditingController();

  // =====================
  // LIST GENRE
  // =====================
  final List<String> genreList = [

    'Horor',
    'Romance',
    'Thriller',
    'Fantasi',
    'Misteri',
  ];

  String selectedGenre =
      'Horor';

  // =====================
  // SHARED PREFERENCES
  // =====================
  String lastGenre = '-';
  String lastForum = '-';

  @override
  void initState() {
    super.initState();
    loadLastData();
  }

  // =====================
  // LOAD SHARED PREF
  // =====================
  Future<void> loadLastData() async {

    final prefs =
    await SharedPreferences
        .getInstance();

    setState(() {

      lastGenre =
          prefs.getString(
            'lastGenre',
          ) ??
              '-';

      lastForum =
          prefs.getString(
            'lastForum',
          ) ??
              '-';
    });
  }

  // =====================
  // TAMBAH FORUM
  // =====================
  Future<void> tambahForum() async {

    if (judulC.text.isEmpty ||
        isiC.text.isEmpty) {
      return;
    }

    try {

      final db =
      await DatabaseHelper.getDatabase();

      await db.insert(
        'forum',
        {
          'judul': judulC.text,
          'isi': isiC.text,
          'genre': selectedGenre,
          'status': 'pending',
        },
      );

      print("BERHASIL INSERT");

      final prefs =
      await SharedPreferences.getInstance();

      await prefs.setString(
        'lastGenre',
        selectedGenre,
      );

      await prefs.setString(
        'lastForum',
        judulC.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ListForumPage(),
        ),
      );
      print("SEBELUM PINDAH");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ListForumPage(),
        ),
      );

      print("SESUDAH PINDAH");

    } catch (e) {

      print("===============");
      print("ERROR DATABASE");
      print(e);
      print("===============");
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
            'Forum Diskusi'),

        backgroundColor:
        Colors.blue,
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding:
          const EdgeInsets.all(16),

          child: Column(

            children: [

              // =====================
              // CARD SHARED PREF
              // =====================
              Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(
                    16),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [

                    const Text(

                      'Data Terakhir',

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      'Genre terakhir: $lastGenre',
                    ),

                    Text(
                      'Forum terakhir: $lastForum',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =====================
              // DROPDOWN GENRE
              // =====================
              DropdownButtonFormField(

                value: selectedGenre,

                decoration:
                InputDecoration(

                  filled: true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                        14),
                  ),
                ),

                items:
                genreList.map((genre) {

                  return DropdownMenuItem(

                    value: genre,

                    child: Text(genre),
                  );
                }).toList(),

                onChanged: (value) {

                  setState(() {

                    selectedGenre =
                    value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              // =====================
              // INPUT JUDUL
              // =====================
              TextField(

                controller: judulC,

                decoration:
                InputDecoration(

                  hintText:
                  'Judul Forum',

                  filled: true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                        14),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // =====================
              // INPUT ISI
              // =====================
              TextField(

                controller: isiC,

                maxLines: 3,

                decoration:
                InputDecoration(

                  hintText:
                  'Isi Forum',

                  filled: true,

                  fillColor:
                  Colors.white,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                        14),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // =====================
              // BUTTON TAMBAH
              // =====================
              SizedBox(

                width: double.infinity,

                height: 50,

                child: ElevatedButton(

                  onPressed:
                  tambahForum,

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    Colors.blue,
                  ),

                  child: const Text(

                    'Tambah Forum',

                    style: TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}