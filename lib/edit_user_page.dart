import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/global_data.dart';
import 'database_helper.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late int userId;

  TextEditingController usernameC = TextEditingController();
  TextEditingController socialC = TextEditingController();

  bool isLoading = true;

  // ================= FOTO PROFIL =================
  String fotoProfil = '';

  // ================= SHARED PREFERENCES =================
  String lastEditedUser = "-";
  int lastEditedId = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userId = ModalRoute.of(context)!.settings.arguments as int;

    fetchUser();
    loadSharedPrefs();
  }

  // ================= SQLITE GET DETAIL =================
  Future<void> fetchUser() async {

    final user =
    await DatabaseHelper.getUserById(userId);

    setState(() {

      usernameC.text = user['username'];

      socialC.text = user['social_media'];

      fotoProfil = user['foto_profil'];

      isLoading = false;
    });
  }

  // ================= SHARED PREFERENCES =================
  Future<void> loadSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      lastEditedUser = prefs.getString('lastEditedUser') ?? '-';
      lastEditedId = prefs.getInt('lastEditedId') ?? 0;
    });
  }

  // ================= SQLITE UPDATE =================
  Future<void> saveUser() async {
    final updatedUser = UserModel(
      id: userId,
      username: usernameC.text,
      socialMedia: socialC.text,

      // FOTO TETAP DISIMPAN
      fotoProfil: fotoProfil,
    );

    await DatabaseHelper.updateUser(
      userId,
      usernameC.text,
      socialC.text,
      fotoProfil,
    );

    // ================= SHARED PREFERENCES =================
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'lastEditedUser',
      usernameC.text,
    );

    await prefs.setInt(
      'lastEditedId',
      userId,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "User berhasil diperbarui",
        ),
      ),
    );

    Navigator.pop(context, true);
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Latar belakang yang lebih modern
      appBar: AppBar(
        title: const Text(
          "Edit User",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
        ),
      )
          : SingleChildScrollView( // Ditambahkan agar tidak error saat keyboard muncul
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= SHARED PREFERENCES INFO =================
              Card(
                elevation: 2,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.edit_note_rounded,
                          color: Colors.orange.shade700,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Terakhir Diedit",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Username : $lastEditedUser",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "ID User      : $lastEditedId",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                "Informasi Pengguna",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              // ================= USERNAME =================
              TextField(
                controller: usernameC,
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Masukkan username",
                  prefixIcon: Icon(Icons.person_outline, color: Colors.blue.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= SOCIAL MEDIA =================
              TextField(
                controller: socialC,
                decoration: InputDecoration(
                  labelText: "Social Media",
                  hintText: "Contoh: @username",
                  prefixIcon: Icon(Icons.alternate_email, color: Colors.blue.shade400),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ================= TOMBOL SIMPAN =================
              SizedBox(
                width: double.infinity,
                height: 55, // Tombol dibuat sedikit lebih tinggi agar nyaman ditekan
                child: ElevatedButton.icon(
                  onPressed: saveUser,
                  icon: const Icon(Icons.save_rounded, color: Colors.white),
                  label: const Text(
                    "Simpan Perubahan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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