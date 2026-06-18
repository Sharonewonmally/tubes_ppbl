import 'package:flutter/material.dart';
import 'forum_local_page.dart';
import 'admin_login_page.dart';
import 'genre_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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

                    'Sharone',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
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
            // =========================
            // PROFIL
            // =========================
            ListTile(

              leading:
              const Icon(Icons.person),

              title:
              const Text('Profil'),

              onTap: () {

                showDialog(

                  context: context,

                  builder: (_) {

                    return const AlertDialog(

                      title: Text('Profil'),

                      content: Text(

                        'Nama: Sharone\n'
                            'Kelas: D3SI\n'
                            'Assessment 2 Flutter',
                      ),
                    );
                  },
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

      body: Padding(

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

                Expanded(
                  child: GestureDetector(

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const ForumLocalPage(),
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
                            Icons.forum,
                            size: 45,
                            color: Colors.blue,
                          ),

                          SizedBox(height: 10),

                          Text('Forum Diskusi'),
                        ],
                      ),
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
                          const GenrePage(),
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
                            Icons.book,
                            size: 45,
                            color: Colors.orange,
                          ),

                          SizedBox(height: 10),

                          Text('Genre Buku'),
                        ],
                      ),
                    ),
                  ),
                ),
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

                        Text('Profil'),
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
          ],
        ),
      ),
    );
  }
}