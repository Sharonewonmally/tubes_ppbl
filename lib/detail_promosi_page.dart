import 'package:flutter/material.dart';

class DetailPromosiPage extends StatelessWidget {

  final Map<String, dynamic> data;

  const DetailPromosiPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(data['judul']),
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Image.asset(
              data['gambar'],
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            Padding(

              padding:
              const EdgeInsets.all(16),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    data['judul'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    data['tanggal'],
                  ),

                  const SizedBox(height: 20),

                  Text(
                    data['isi'],
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