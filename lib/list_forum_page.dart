import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_helper.dart';
import 'detail_forum_page.dart';
import 'forum_card.dart';

class ListForumPage extends StatefulWidget {
  const ListForumPage({super.key});

  @override
  State<ListForumPage> createState() =>
      _ListForumPageState();
}

class _ListForumPageState
    extends State<ListForumPage> {

  List<Map<String, dynamic>> forumList = [];

  String lastForum = "-";
  String lastGenre = "-";

  @override
  void initState() {
    super.initState();

    getForum();
    loadPrefs();
  }

  // =====================
  // GET FORUM
  // =====================
  Future<void> getForum() async {

    final db =
    await DatabaseHelper.getDatabase();

    final data = await db.query(
      'forum',
      where: 'status=?',
      whereArgs: ['pending'],
      orderBy: 'id DESC',
    );

    setState(() {
      forumList = data;
    });
  }

  // =====================
  // SHARED PREFERENCES
  // =====================
  Future<void> saveLastForum(
      String judul,
      String genre,
      ) async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      'lastForum',
      judul,
    );

    await prefs.setString(
      'lastGenre',
      genre,
    );
  }

  Future<void> loadPrefs() async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {

      lastForum =
          prefs.getString(
              'lastForum') ??
              "-";

      lastGenre =
          prefs.getString(
              'lastGenre') ??
              "-";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xffEAF4FF),

      appBar: AppBar(

        title:
        const Text('List Forum'),

        backgroundColor:
        Colors.blue,
      ),

      body: Column(

        children: [

          Container(

            width: double.infinity,

            margin:
            const EdgeInsets.all(10),

            padding:
            const EdgeInsets.all(10),

            decoration: BoxDecoration(

              color:
              Colors.blue.shade50,

              borderRadius:
              BorderRadius.circular(
                  12),
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  "Forum Terakhir : $lastForum",
                ),

                Text(
                  "Genre Terakhir : $lastGenre",
                ),
              ],
            ),
          ),

          Expanded(

            child: forumList.isEmpty

                ? const Center(
              child:
              Text(
                  'Belum ada forum'),
            )

                : ListView.builder(

              padding:
              const EdgeInsets.all(
                  16),

              itemCount:
              forumList.length,

              itemBuilder:
                  (context, index) {

                final data =
                forumList[index];

                return ForumCard(

                  forum: data,

                  onTap: () async {

                    await saveLastForum(

                      data['judul'],

                      data['genre'],
                    );

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                            DetailForumPage(
                              forum: data,
                            ),
                      ),
                    );
                  },

                  onLongPress: () {

                    ScaffoldMessenger.of(
                        context)
                        .showSnackBar(

                      SnackBar(

                        content: Text(
                          "Forum : ${data['judul']}",
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}