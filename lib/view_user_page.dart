import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import 'models/user_model.dart';

class ViewUserPage extends StatefulWidget {
  const ViewUserPage({super.key});

  @override
  State<ViewUserPage> createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  late int userId;

  UserModel? user;

  bool isLoading = true;

  String lastViewedUser = "-";
  int lastViewedId = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userId =
    ModalRoute.of(context)!.settings.arguments
    as int;

    fetchUserDetail();
    loadSharedPrefs();
  }

  // ================= SQLITE =================
  Future<void> fetchUserDetail() async {
    final data =
    await DatabaseHelper.getUserById(userId);

    final fetchedUser =
    UserModel.fromMap(data);

    // ================= SHARED PREFERENCES =================
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      'lastViewedUser',
      fetchedUser.username,
    );

    await prefs.setInt(
      'lastViewedId',
      fetchedUser.id,
    );

    setState(() {
      user = fetchedUser;

      isLoading = false;
    });
  }

  // ================= LOAD SHARED PREFS =================
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

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail User"),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )

          : Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // ================= SHARED PREFERENCES =================
            Container(
              width: double.infinity,

              padding:
              const EdgeInsets.all(12),

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
                      fontWeight:
                      FontWeight.bold,

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

            const SizedBox(height: 40),

            // ================= FOTO PROFIL =================
            CircleAvatar(
              radius: 80,

              backgroundImage:
              AssetImage(
                user!.fotoProfil,
              ),
            ),

            const SizedBox(height: 25),

            // ================= USERNAME =================
            Text(
              user!.username,

              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // ================= SOCIAL MEDIA =================
            Text(
              user!.socialMedia,

              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}