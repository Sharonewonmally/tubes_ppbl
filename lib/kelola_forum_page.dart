import 'package:flutter/material.dart';
import 'database_helper.dart';

class KelolaForumPage extends StatefulWidget {
  const KelolaForumPage({super.key});

  @override
  State<KelolaForumPage> createState() =>
      _KelolaForumPageState();
}

class _KelolaForumPageState
    extends State<KelolaForumPage> {

  List<Map<String, dynamic>>
  forumList = [];

  @override
  void initState() {
    super.initState();
    getForum();
  }

  Future<void> getForum() async {

    final db =
    await DatabaseHelper.getDatabase();

    final data = await db.query(
      'forum',
      orderBy: 'id DESC',
    );

    setState(() {
      forumList = data;
    });
  }

  Future<void> approveForum(
      int id) async {

    final db =
    await DatabaseHelper.getDatabase();

    await db.update(
      'forum',
      {
        'status': 'approved',
      },
      where: 'id=?',
      whereArgs: [id],
    );

    getForum();
  }

  Future<void> deleteForum(
      int id) async {

    final db =
    await DatabaseHelper.getDatabase();

    await db.delete(
      'forum',
      where: 'id=?',
      whereArgs: [id],
    );

    getForum();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text(
            "Kelola Forum"),
      ),

      body: forumList.isEmpty

          ? const Center(
        child:
        Text(
            "Belum ada forum"),
      )

          : ListView.builder(

        itemCount:
        forumList.length,

        itemBuilder:
            (context, index) {

          final forum =
          forumList[index];

          return Card(

            margin:
            const EdgeInsets.all(
                10),

            child: Padding(

              padding:
              const EdgeInsets.all(
                  12),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment
                    .start,

                children: [

                  Text(

                    forum['judul'],

                    style:
                    const TextStyle(

                      fontSize: 18,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 5),

                  Text(
                    forum['isi'],
                  ),

                  const SizedBox(
                      height: 5),

                  Text(
                    "Genre : ${forum['genre']}",
                  ),

                  Text(
                    "Status : ${forum['status']}",
                  ),

                  const SizedBox(
                      height: 10),

                  Row(

                    children: [

                      ElevatedButton(

                        onPressed: () {

                          approveForum(
                              forum['id']);
                        },

                        child:
                        const Text(
                            "Approve"),
                      ),

                      const SizedBox(
                          width: 10),

                      ElevatedButton(

                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.red,
                        ),

                        onPressed: () {

                          deleteForum(
                              forum['id']);
                        },

                        child:
                        const Text(
                          "Delete",
                          style:
                          TextStyle(
                            color:
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}