import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/comment_model.dart';
import 'database_helper.dart';

class KomentarPage extends StatefulWidget {
  const KomentarPage({super.key});

  @override
  State<KomentarPage> createState() => _KomentarPageState();
}

class _KomentarPageState extends State<KomentarPage> {
  final usernameController = TextEditingController();
  final commentController = TextEditingController();

  List<CommentModel> comments = [];
  String lastUsername = "-";

  @override
  void initState() {
    super.initState();
    loadComments();
    loadUsername();
  }

  Future<void> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      lastUsername = prefs.getString("username") ?? "-";
    });
  }

  Future<void> saveUsername() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "username",
      usernameController.text,
    );
  }

  Future<void> loadComments() async {
    final data =
    await DatabaseHelper.getKomentarByForum(1);

    setState(() {
      comments = data
          .map((e) => CommentModel.fromMap(e))
          .toList();
    });
  }

  Future<void> addComment() async {
    if (usernameController.text.isEmpty ||
        commentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lengkapi username dan komentar"),
        ),
      );
      return;
    }

    await DatabaseHelper.tambahKomentar(
      1,
      usernameController.text,
      commentController.text,
    );

    await saveUsername();

    usernameController.clear();
    commentController.clear();

    await loadUsername();
    await loadComments();
  }

  Future<void> deleteComment(int id) async {
    await DatabaseHelper.hapusKomentar(id);
    await loadComments();
  }

  void showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Komentar"),
        content: const Text(
          "Apakah Anda yakin ingin menghapus komentar ini?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await deleteComment(id);
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Komentar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Username Terakhir\n$lastUsername",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon:
                        const Icon(Icons.person_outline),
                        labelText: "Username",
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        prefixIcon:
                        const Icon(Icons.comment_outlined),
                        labelText: "Komentar",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: addComment,
                        icon: const Icon(Icons.send),
                        label: const Text(
                          "Tambah Komentar",
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: comments.isEmpty
                ? const Center(
              child: Text(
                "Belum ada komentar",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final c = comments[index];

                return Card(
                  margin:
                  const EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        c.username[0].toUpperCase(),
                      ),
                    ),
                    title: Text(
                      c.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding:
                      const EdgeInsets.only(top: 5),
                      child: Text(c.comment),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      onPressed: () =>
                          showDeleteDialog(c.id!),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}