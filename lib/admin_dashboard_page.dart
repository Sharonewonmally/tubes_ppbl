import 'package:flutter/material.dart';
import 'kelola_forum_page.dart';
import 'user_list_page.dart';


class AdminDashboardPage
    extends StatelessWidget {

  const AdminDashboardPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: Drawer(

        child: ListView(

          children: [

            const DrawerHeader(

              decoration:
              BoxDecoration(
                color: Colors.blue,
              ),

              child: Column(

                mainAxisAlignment:
                MainAxisAlignment.end,

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.admin_panel_settings,
                    color:
                    Colors.white,
                    size: 50,
                  ),

                  SizedBox(
                      height: 10),

                  Text(

                    'ADMIN',

                    style: TextStyle(

                      color:
                      Colors.white,

                      fontSize: 22,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(

              leading:
              const Icon(
                  Icons.dashboard),

              title:
              const Text(
                  'Dashboard'),

              onTap: () {

                Navigator.pop(
                    context);
              },
            ),

            ListTile(

              leading:
              const Icon(Icons.forum),

              title:
              const Text('Kelola Forum'),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const KelolaForumPage(),
                  ),
                );
              },
            ),

            ListTile(

              leading:
              const Icon(Icons.people),

              title:
              const Text('Kelola User'),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                    const UserListPage(),
                  ),
                );
              },
            ),

            ListTile(

              leading:
              const Icon(
                  Icons.logout),

              title:
              const Text(
                  'Logout'),

              onTap: () {

                Navigator.popUntil(
                  context,
                      (route) =>
                  route.isFirst,
                );
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(

        title:
        const Text(
            'Dashboard Admin'),

        backgroundColor:
        Colors.blue,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // =====================
            // WELCOME CARD
            // =====================
            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(20),

              decoration: BoxDecoration(

                gradient:
                const LinearGradient(

                  colors: [
                    Color(0xff1565C0),
                    Color(0xff42A5F5),
                  ],
                ),

                borderRadius:
                BorderRadius.circular(20),
              ),

              child: const Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    "Welcome Admin 👋",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(

                    "Kelola forum dan user dengan mudah",

                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(

              "Menu Admin",

              style: TextStyle(

                fontSize: 20,

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(

              children: [

                Expanded(

                  child: GestureDetector(

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                          const KelolaForumPage(),
                        ),
                      );
                    },

                    child: Container(

                      height: 140,

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                            20),

                        boxShadow: const [

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
                            size: 50,
                            color: Colors.blue,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Kelola Forum",
                          ),
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
                          const UserListPage(),
                        ),
                      );
                    },

                    child: Container(

                      height: 140,

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(
                            20),

                        boxShadow: const [

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
                            Icons.people,
                            size: 50,
                            color: Colors.green,
                          ),

                          SizedBox(height: 10),

                          Text(
                            "Kelola User",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(16),

              decoration: BoxDecoration(

                color:
                Colors.orange.shade50,

                borderRadius:
                BorderRadius.circular(
                    16),
              ),

              child: const Row(

                children: [

                  Icon(
                    Icons.info,
                    color: Colors.orange,
                  ),

                  SizedBox(width: 10),

                  Expanded(

                    child: Text(

                      "Admin dapat mengelola forum, user, dan memoderasi diskusi.",

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}