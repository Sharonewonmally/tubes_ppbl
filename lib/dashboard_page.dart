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

              padding:
              const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.blue,

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: const Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    'Selamat Datang 👋',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(

                    'Aplikasi Forum Diskusi Buku',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

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

                // =====================
                // FORUM
                // =====================
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
                            Icons.forum,
                            size: 45,
                            color: Colors.blue,
                          ),

                          SizedBox(height: 10),

                          Text(
                            'Forum Diskusi',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

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