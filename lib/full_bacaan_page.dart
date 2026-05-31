import 'package:flutter/material.dart';
import 'komentar_page.dart';

class FullBacaanPage extends StatelessWidget {
  final String title;

  const FullBacaanPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Text(
                      "BAB 1 \n\n"
                          "Raib, gadis istimewa keturunan Klan Bulan, memiliki kemampuan menghilang dan mewarisi Buku Kehidupan yang membuka portal ke dunia lain. Seli, sang penjinak api dari Klan Matahari, dikenal tekadnya yang kuat dan pantang menyerah."
                          "Sementara Ali, pemuda pemberani dari Klan Bumi, memiliki kemampuan unik berkomunikasi dengan hewan. Mereka saling menyadari memiliki kekuatan super ketika terjadi insiden tower listrik di sekolah jatuh menimpa mereka. "
                          "Alih-alih celaka, ketiganya mampu mengendalikan jatuhnya tiang listrik dan membuat Tamus mengetahui keberadaan mereka.",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: SizedBox(
                width: 220,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KomentarPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.comment),
                  label: const Text(
                    "Tambah Komentar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}