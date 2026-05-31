import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database_helper.dart';
import 'models/user_model.dart';

import 'view_user_page.dart';
import 'edit_user_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List<UserModel> users = [];
  List<UserModel> allUsers = [];

  TextEditingController searchC = TextEditingController();

  bool isLoading = true;

  // ================= SHARED PREFERENCES =================
  String lastViewedUser = "-";
  int lastViewedId = 0;

  @override
  void initState() {
    super.initState();

    fetchUsers();
    loadSharedPrefs();
  }

  // ================= SQLITE GET USERS =================
  Future<void> fetchUsers() async {

    final usersData =
    await DatabaseHelper.getUsers();

    setState(() {

      users = usersData
          .map(
            (e) => UserModel.fromMap(e),
      )
          .toList();

      allUsers = users;

      isLoading = false;
    });
  }

  // ================= SHARED PREFERENCES =================
  Future<void> loadSharedPrefs() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {
      lastViewedUser =
          prefs.getString('lastViewedUser') ?? '-';

      lastViewedId =
          prefs.getInt('lastViewedId') ?? 0;
    });
  }

  // ================= SEARCH =================
  void searchUser() {
    String text = searchC.text.toLowerCase();

    setState(() {
      users = allUsers
          .where(
            (u) => u.username
            .toLowerCase()
            .contains(text),
      )
          .toList();
    });
  }

  // ================= SQLITE DELETE =================
  Future<void> deleteUser(int id) async {
    await DatabaseHelper.deleteUser(id);

    fetchUsers();

    showSnack("User berhasil dihapus");
  }

  // ================= SNACKBAR =================
  void showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  // ================= DIALOG =================
  void showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus User"),
        content: const Text(
          "Apakah kamu yakin ingin menghapus user ini?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              deleteUser(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar User"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),


      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [

          // ================= SHARED PREFERENCES =================
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius:
              BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  "Shared Preferences",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Last Viewed User: $lastViewedUser",
                ),

                Text(
                  "Last Viewed ID: $lastViewedId",
                ),
              ],
            ),
          ),

          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchC,
                    decoration:
                    const InputDecoration(
                      hintText:
                      "Cari username...",
                      prefixIcon:
                      Icon(Icons.search),
                      border:
                      OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: searchUser,
                  child: const Text("Cari"),
                ),
              ],
            ),
          ),

          // ================= LIST USER =================
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) {
                final u = users[i];

                return Card(
                  margin:
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(

                    // ================= FOTO PROFIL =================
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      AssetImage(
                        u.fotoProfil,
                      ),
                    ),

                    title: Text(
                      u.username,
                      style: const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      u.socialMedia,
                    ),

                    trailing: PopupMenuButton(
                      onSelected:
                          (value) async {

                        // ================= LIHAT =================
                        if (value == "lihat") {

                          SharedPreferences prefs =
                          await SharedPreferences
                              .getInstance();

                          await prefs.setString(
                            'lastViewedUser',
                            u.username,
                          );

                          await prefs.setInt(
                            'lastViewedId',
                            u.id,
                          );

                          loadSharedPrefs();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const ViewUserPage(),

                              settings:
                              RouteSettings(
                                arguments:
                                u.id,
                              ),
                            ),
                          );
                        }

                        // ================= EDIT =================
                        else if (value ==
                            "edit") {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const EditUserPage(),

                              settings:
                              RouteSettings(
                                arguments:
                                u.id,
                              ),
                            ),
                          ).then(
                                (_) => fetchUsers(),
                          );
                        }

                        // ================= HAPUS =================
                        else if (value ==
                            "hapus") {

                          showDeleteDialog(
                            u.id,
                          );
                        }
                      },

                      itemBuilder: (context) =>
                      const [

                        PopupMenuItem(
                          value: "lihat",
                          child:
                          Text("Lihat"),
                        ),

                        PopupMenuItem(
                          value: "edit",
                          child:
                          Text("Edit"),
                        ),

                        PopupMenuItem(
                          value: "hapus",
                          child: Text(
                            "Hapus",
                            style: TextStyle(
                              color:
                              Colors.red,
                            ),
                          ),
                        ),
                      ],
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