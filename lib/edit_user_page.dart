import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'models/user_model.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late int userId;

  TextEditingController usernameC =
  TextEditingController();

  TextEditingController socialC =
  TextEditingController();

  bool isLoading = true;

  // ================= SHARED PREFERENCES =================
  String lastEditedUser = "-";
  int lastEditedId = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userId =
    ModalRoute.of(context)!.settings.arguments as int;

    fetchUser();
    loadSharedPrefs();
  }

  // ================= SQLITE GET DETAIL =================
  Future<void> fetchUser() async {

    final data =
    await DatabaseHelper.getUserById(userId);

    setState(() {

      usernameC.text =
      data['username'];

      socialC.text =
      data['social_media'];

      isLoading = false;
    });
  }

  // ================= SHARED PREFERENCES =================
  Future<void> loadSharedPrefs() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {
      lastEditedUser =
          prefs.getString('lastEditedUser') ?? '-';

      lastEditedId =
          prefs.getInt('lastEditedId') ?? 0;
    });
  }

  // ================= SQLITE UPDATE =================
  Future<void> saveUser() async {
    final updatedUser = UserModel(
      id: userId,
      username: usernameC.text,
      socialMedia: socialC.text,
      fotoProfil: '',
    );

    await DatabaseHelper.updateUser(

      userId,

      usernameC.text,

      socialC.text,

      '',
    );

    // ================= SHARED PREFERENCES =================
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

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
      appBar: AppBar(
        title: const Text("Edit User"),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ================= SHARED PREFERENCES INFO =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
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
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Last Edited User: $lastEditedUser",
                  ),
                  Text(
                    "Last Edited ID: $lastEditedId",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              controller: usernameC,
              decoration:
              const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: socialC,
              decoration:
              const InputDecoration(
                labelText: "Social Media",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveUser,
                child: const Text("Simpan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}