import 'package:flutter/material.dart';
import 'admin_dashboard_page.dart';

class AdminLoginPage extends StatefulWidget {

  const AdminLoginPage({
    super.key,
  });

  @override
  State<AdminLoginPage> createState() =>
      _AdminLoginPageState();
}

class _AdminLoginPageState
    extends State<AdminLoginPage> {

  final usernameC =
  TextEditingController();

  final passwordC =
  TextEditingController();

  String error = '';

  void login() {

    if (usernameC.text == "admin" &&
        passwordC.text == "123") {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>
          const AdminDashboardPage(),
        ),
      );

    } else {

      setState(() {

        error =
        "Username atau Password Salah";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xffEAF4FF),

      appBar: AppBar(

        title:
        const Text(
            'Login Admin'),

        backgroundColor:
        Colors.blue,
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            const Icon(

              Icons.admin_panel_settings,

              size: 100,

              color: Colors.blue,
            ),

            const SizedBox(
                height: 20),

            TextField(

              controller:
              usernameC,

              decoration:
              const InputDecoration(

                labelText:
                'Username',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 15),

            TextField(

              controller:
              passwordC,

              obscureText: true,

              decoration:
              const InputDecoration(

                labelText:
                'Password',

                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
                height: 20),

            SizedBox(

              width:
              double.infinity,

              child:
              ElevatedButton(

                onPressed:
                login,

                child:
                const Text(
                    'LOGIN'),
              ),
            ),

            const SizedBox(
                height: 10),

            Text(

              error,

              style:
              const TextStyle(
                color:
                Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}