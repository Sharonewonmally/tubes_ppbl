import 'package:flutter/material.dart';
import 'forum_local_page.dart';
import 'admin_login_page.dart';
import 'genre_page.dart';
import 'detail_promosi_page.dart';
import 'database_helper.dart';
import 'favorite_page.dart';
import 'reward_page.dart';
import 'buku_premium_page.dart';
import 'resume_page.dart';
import 'riwayat_baca_page.dart';
import 'tulis_buku_page.dart';
import 'karya_saya_page.dart';
import 'profile_page.dart';
import 'dart:io';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends State<DashboardPage> {
  List<Map<String ,dynamic>> promosiList = [];

  @override
  void initState() {
    super.initState();
    loadPromosi();
  }

  Future<void> loadPromosi() async {

    final data =
    await DatabaseHelper.getPromosi();

    setState(() {
      promosiList = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // =========================
      // SIDEBAR
      // =========================
      drawer: Drawer(

        child: ListView(

          children: [

            // =========================
            // HEADER
            // =========================
            const DrawerHeader(

              decoration: BoxDecoration(
                color: Colors.blue,
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                mainAxisAlignment:
                MainAxisAlignment.end,

                children: [

                  CircleAvatar(
                    radius: 30,

                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(

                    'Adzra',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
// =========================
            // PROFIL
            // =========================
           ListTile(

  leading: const Icon(Icons.person),

  title: const Text('Profil'),

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const ProfilePage(),

      ),

    );

  },

),

            // =========================
            // DASHBOARD
            // =========================
            ListTile(

              leading:
              const Icon(Icons.home),

              title:
              const Text('Dashboard'),

              onTap: () {

                Navigator.pop(context);
              },
            ),

            // =========================
            // FORUM DISKUSI
            // =========================
            ListTile(

              leading:
              const Icon(Icons.forum),

              title:
              const Text('Forum Diskusi'),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const ForumLocalPage(),
                  ),
                );
              },
            ),

            // =========================
            // GENRE BUKU
            // =========================
            ListTile(

              leading:
              const Icon(Icons.book),

              title:
              const Text('Genre Buku'),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => const GenrePage(),
                  ),
                );
              },
            ),
            ListTile(
  leading: const Icon(Icons.menu_book),
  title: const Text('Resume Buku'),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ResumePage(),
      ),
    );
  },
),

ListTile(
  leading: const Icon(Icons.history),
  title: const Text("Riwayat Baca"),
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RiwayatBacaPage(),
      ),
    );

  },
),
            // =========================
// REWARD
// =========================
ListTile(

  leading: const Icon(Icons.card_giftcard),

  title: const Text('Reward'),

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const RewardPage(
          userId: 1,
        ),
      ),
    );
  },
),
ListTile(
  leading: const Icon(Icons.edit),
  title: const Text('Tulis Buku'),
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const TulisBukuPage(),
      ),
    );

  },
),

ListTile(
  leading: const Icon(Icons.library_books),
  title: const Text('Karya Saya'),
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const KaryaSayaPage(),
      ),
    );

  },
),
// =========================
// BUKU PREMIUM
// =========================
ListTile(

  leading: const Icon(Icons.workspace_premium),

  title: const Text('Buku Premium'),

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => const BukuPremiumPage(
          userId: 1,
        ),
      ),
    );
  },
),
            // =========================
// FAVORIT
// =========================
ListTile(

  leading:
  const Icon(Icons.favorite),

  title:
  const Text('Buku Favorit'),

  onTap: () {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) =>
        const FavoritePage(),
      ),
    );
  },
),

            
            // ADMIN DASHBOARD
            ListTile(

              leading:
              const Icon(Icons.admin_panel_settings),

              title:
              const Text('Login Admin'),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const AdminLoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),



      // =========================
      // BODY
      // =========================
      backgroundColor:
      const Color(0xffEAF4FF),

      appBar: AppBar(

        title: const Text(
          'Dashboard',
        ),

        centerTitle: true,

        backgroundColor:
        Colors.blue,
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

            const SizedBox(height: 20),

            // =====================
            // WELCOME CARD
            // =====================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xff1976D2),
                    Color(0xff42A5F5),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundImage:
                      AssetImage("assets/pfp-adzra.jpeg"),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Welcome Back 👋",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Adzra Aditama",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 5),

                        Text(
                          "Forum Diskusi & Buku Digital",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Text(

              'Menu Utama',

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // =====================
// MENU CARD
// =====================

            Row(
              children: [



                const SizedBox(width: 15),


              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: Container(

                    height: 130,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        ),
                      ],
                    ),

                    child: const Column(

                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Icon(
                          Icons.person,
                          size: 45,
                          color: Colors.green,
                        ),

                        SizedBox(height: 10),

                        Text('Forum diskusi'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: GestureDetector(

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const AdminLoginPage(),
                        ),
                      );
                    },

                    child: Container(

                      height: 130,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                          ),
                        ],
                      ),

                      child: const Column(

                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.admin_panel_settings,
                            size: 45,
                            color: Colors.red,
                          ),

                          SizedBox(height: 10),

                          Text('Admin'),
                        ],
                      ),
                    ),
                  ),
                ),


                // =====================
                // GENRE
                // =====================
                Expanded(

                  child: Container(

                    height: 130,

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                          20),

                      boxShadow: [

                        BoxShadow(
                          color:
                          Colors.black12,

                          blurRadius: 5,
                        ),
                      ],
                    ),

                    child: const Column(

                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Icon(
                          Icons.book,
                          size: 45,
                          color: Colors.orange,
                        ),

                        SizedBox(height: 10),

                        Text(
                          'Genre Buku',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
              const SizedBox(height: 25),

              const Text(
                "Info Komunitas & Lomba",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                     ...promosiList.map((data) {

  return GestureDetector(

    onTap: () {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              DetailPromosiPage(
                data: data,
              ),
        ),
      );
    },

    child: Card(

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          if (data['gambar'] != null &&
              data['gambar']
                  .toString()
                  .isNotEmpty)

            ClipRRect(

              borderRadius:
                  const BorderRadius.vertical(
                top: Radius.circular(12),
              ),

              child: Image.file(

                File(data['gambar']),

                width: double.infinity,
                height: 180,

                fit: BoxFit.cover,
              ),
            ),

          Padding(

            padding:
                const EdgeInsets.all(12),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  data['judul'],

                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(data['isi']),

                const SizedBox(
                  height: 5,
                ),

                Text(

                  data['tanggal'],

                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

}).toList(),

                    ],
                  ),
              ),
              ],
          ),
        ),
      ),
    );
  }
}