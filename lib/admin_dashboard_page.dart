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

      body: const Center(

        child: Text(

          'Selamat Datang Admin',

          style: TextStyle(

            fontSize: 24,

            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}