import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_helper.dart';
import '../models/comment_model.dart';

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
  String lastComment = "-";

  @override
  void initState() {
    super.initState();

    loadComments();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {

      lastUsername = prefs.getString("username") ?? "-";
      lastComment = prefs.getString("last_comment") ?? "-";
    });
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      "username",
      usernameController.text,
    );

    await prefs.setString(
      "last_comment",
      commentController.text,
    );
  }

  Future<void> loadComments() async {
  final data =
      await DatabaseHelper.ambilSemuaKomentarfeby();

  setState(() {
    comments = data
        .map((e) => CommentModel(
              id: e['id'],
              username: e['username'],
              pesan: e['comment'],
            ))
        .toList();
  });
}

 Future<void> addComment() async {
  try {
    if (usernameController.text.trim().isEmpty ||
        commentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Lengkapi username dan komentar"),
        ),
      );
      return;
    }

    await DatabaseHelper.tambahKomentarFeby(
      CommentModel(
        username: usernameController.text,
        pesan: commentController.text,
      ),
    );

    // SIMPAN KE SHAREDPREFERENCES
    await savePreferences();

    // REFRESH DATA SHAREDPREFERENCES
    await loadPreferences();

    // REFRESH KOMENTAR
    await loadComments();

    // KOSONGKAN FORM
    usernameController.clear();
    commentController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Komentar berhasil ditambahkan"),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Error: $e"),
      ),
    );
  }
}

  Future<void> deleteComment(int id) async {
    await DatabaseHelper.hapusKomentarfeby(id);
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
            onPressed: () {
              Navigator.pop(context);
            },
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
  void dispose() {
    usernameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Komentar Buku",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: "Username",
                        prefixIcon:
                            const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: commentController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Komentar",
                        prefixIcon:
                            const Icon(Icons.comment),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
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
                        style:
                            ElevatedButton.styleFrom(
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius:
                            BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade100,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Data SharedPreferences",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Last Username : $lastUsername",
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Last Comment : $lastComment",
                            maxLines: 2,
                            overflow:
                                TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

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
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    itemCount: comments.length,
                    itemBuilder:
                        (context, index) {
                      final c = comments[index];

                      return Card(
                        margin:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),
                        elevation: 2,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            15,
                          ),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                              c.username[0]
                                  .toUpperCase(),
                            ),
                          ),
                          title: Text(
                            c.username,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          subtitle: Padding(
                            padding:
                                const EdgeInsets.only(
                              top: 4,
                            ),
                            child: Text(
                              c.pesan,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                showDeleteDialog(
                              c.id!,
                            ),
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