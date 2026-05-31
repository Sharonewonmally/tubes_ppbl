import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'dashboard_page.dart';

class LoginUserPage extends StatefulWidget {
  const LoginUserPage({super.key});

  @override
  State<LoginUserPage> createState() =>
      _LoginUserPageState();
}

class _LoginUserPageState
    extends State<LoginUserPage> {

  final usernameC =
  TextEditingController();

  final passwordC =
  TextEditingController();

  Future<void> login() async {

    final user =
    await DatabaseHelper.loginUser(
      usernameC.text,
      passwordC.text,
    );

    if (user == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            "Username atau Password Salah",
          ),
        ),
      );

      return;
    }

    Navigator.pushReplacement(

      context,

      MaterialPageRoute(
        builder: (_) =>
        const DashboardPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
        const Text("Login User"),
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller:
              usernameC,

              decoration:
              const InputDecoration(
                labelText:
                "Username",
              ),
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              passwordC,

              obscureText: true,

              decoration:
              const InputDecoration(
                labelText:
                "Password",
              ),
            ),

            const SizedBox(
                height: 30),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                login,

                child:
                const Text(
                    "Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}