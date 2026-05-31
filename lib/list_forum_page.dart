import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'detail_forum_page.dart';

class ListForumPage extends StatefulWidget {
  const ListForumPage({super.key});

  @override
  State<ListForumPage> createState() =>
      _ListForumPageState();
}

class _ListForumPageState
    extends State<ListForumPage> {

  List<Map<String, dynamic>> forumList = [];

  @override
  void initState() {
    super.initState();
    getForum();
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

      body: forumList.isEmpty

          ? const Center(
        child:
        Text('Belum ada forum'),
      )

          : ListView.builder(

        padding:
        const EdgeInsets.all(16),

        itemCount:
        forumList.length,

        itemBuilder:
            (context, index) {

          final data =
          forumList[index];

          return Card(

            shape:
            RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(
                  16),
            ),

            child: ListTile(

              onTap: () {

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

              leading:
              const CircleAvatar(

                backgroundColor:
                Colors.blue,

                child: Icon(
                  Icons.forum,
                  color:
                  Colors.white,
                ),
              ),

              title: Text(
                data['judul'],
              ),

              subtitle: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    data['genre'],
                  ),

                  Text(
                    "Status : ${data['status']}",
                  ),
                ],
              ),

              trailing:
              const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          );
        },
      ),
    );
  }
}