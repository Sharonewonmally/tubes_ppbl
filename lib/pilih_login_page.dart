import 'package:flutter/material.dart';

import 'login_user_page.dart';
import 'admin_login_page.dart';

class PilihLoginPage extends StatelessWidget {
  const PilihLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xffEAF4FF),

      appBar: AppBar(
        title: const Text("Pilih Login"),
        backgroundColor: Colors.blue,
      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.account_circle,
                size: 120,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

              const Text(
                "Masuk Sebagai",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton.icon(

                  icon: const Icon(Icons.person),

                  label: const Text(
                    "LOGIN USER",
                  ),

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                        const LoginUserPage(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(

                width: double.infinity,

                child: ElevatedButton.icon(

                  icon: const Icon(
                    Icons.admin_panel_settings,
                  ),

                  label: const Text(
                    "LOGIN ADMIN",
                  ),

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>
                        const AdminLoginPage(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}