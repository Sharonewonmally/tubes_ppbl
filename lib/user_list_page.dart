import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/global_data.dart';
import 'edit_user_page.dart';
import 'view_user_page.dart';
import 'database_helper.dart';

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
  //inisialisasi variabel awal dulu
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
    final data = await DatabaseHelper.getUsers();

    setState(() {
      users = data
          .map((e) => UserModel.fromMap(e))
          .toList();

      allUsers = List.from(users);

      isLoading = false;
    });
  }

  // ================= SHARED PREFERENCES =================
  Future<void> loadSharedPrefs() async { //ngambil data dari shared preferences
    SharedPreferences prefs =
    await SharedPreferences.getInstance(); //ngambil objek shared preferences

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
      users = allUsers.where((u) => u.username.toLowerCase().contains(text),).toList();
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Hapus User",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text(
          "Apakah kamu yakin ingin menghapus user ini?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Batal",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              deleteUser(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Latar belakang abu-abu terang
      appBar: AppBar(
        title: const Text(
          "Daftar User",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0, // Dibuat flat
      ),


      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      )
          : Column(
        children: [
          // ================= SHARED PREFERENCES =================
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.history, color: Colors.blue.shade700),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Terakhir Dilihat",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "User: $lastViewedUser  •  ID: $lastViewedId",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchC,
                    decoration: InputDecoration(
                      hintText: "Cari username...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.shade300),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: searchUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Cari",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ================= LIST USER =================
          Expanded(
            child: users.isEmpty
                ? Center(
              child: Text(
                "Data user tidak ditemukan",
                style: TextStyle(color: Colors.grey.shade500),
              ),
            )
                : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: users.length,
              itemBuilder: (context, i) {
                final u = users[i];

                return Card(
                  elevation: 2,
                  shadowColor: Colors.black12,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                    // ================= FOTO PROFIL =================
                    leading: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(u.fotoProfil),
                      ),
                    ),

                    title: Text(
                      u.username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(Icons.alternate_email, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 4),
                          Text(
                            u.socialMedia,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),

                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert, color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) async {
                        // ================= LIHAT =================
                        if (value == "lihat") {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();

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
                              builder: (_) => const ViewUserPage(),
                              settings: RouteSettings(
                                arguments: u.id,
                              ),
                            ),
                          );
                        }

                        // ================= EDIT =================
                        else if (value == "edit") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EditUserPage(),
                              settings: RouteSettings(
                                arguments: u.id,
                              ),
                            ),
                          ).then(
                                (_) => fetchUsers(),
                          );
                        }

                        // ================= HAPUS =================
                        else if (value == "hapus") {
                          showDeleteDialog(u.id);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: "lihat",
                          child: Row(
                            children: [
                              Icon(Icons.visibility_outlined, size: 20),
                              SizedBox(width: 8),
                              Text("Lihat"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "edit",
                          child: Row(
                            children: [
                              Icon(Icons.edit_outlined, size: 20),
                              SizedBox(width: 8),
                              Text("Edit"),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "hapus",
                          child: Row(
                            children: [
                              Icon(Icons.delete_outline, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text("Hapus", style: TextStyle(color: Colors.red)),
                            ],
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