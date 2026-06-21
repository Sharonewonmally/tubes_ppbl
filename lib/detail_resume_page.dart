import 'package:flutter/material.dart';

class DetailResumePage extends StatelessWidget {
  final String judul;
  final String isi;
  final String tanggal;

  const DetailResumePage({
    super.key,
    required this.judul,
    required this.isi,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  tanggal,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const Divider(height: 30),

                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      isi,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}