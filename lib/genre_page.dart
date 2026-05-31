import 'package:flutter/material.dart';

import 'full_bacaan_page.dart';

class GenrePage extends StatelessWidget {
  const GenrePage({super.key});

  @override
  Widget build(BuildContext context) {
    final books = [
      {
        "title": "Bumi",
        "author": "Tere Liye",
        "image": "assets/cover/bumi.jpeg",
      },
      {
        "title": "Bendera Setengah Tiang",
        "author": "Annisa Lim",
        "image": "assets/cover/BST.jpeg",
      },
      {
        "title": "Hujan",
        "author": "Tere Liye",
        "image": "assets/cover/hujan.jpeg",
      },
      {
        "title": "Laut Bercerita",
        "author": "Leila S Chudori",
        "image": "assets/cover/LB.jpeg",
      },
      {
        "title": "KKN di Desa Penari",
        "author": "Simpleman",
        "image": "assets/cover/kkn.jpeg",
      },
      {
        "title": "Negeri Para Bedebah",
        "author": "Tere Liye",
        "image": "assets/cover/NPB.jpeg",
      },
      {
        "title": "White Nights",
        "author": "Fyodor Dostoevsky",
        "image": "assets/cover/WN.png",
      },
      {
        "title": "Naruto",
        "author": "Masashi Kishimoto",
        "image": "assets/cover/naruto.jpeg",
      },
      {
        "title": "Seporsi Mie Ayam Sebelum Mati",
        "author": "Brian Khrisna",
        "image": "assets/cover/SMASM.jpeg",
      },

    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Genre Buku"),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: books.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 buku per baris
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) {
          final book = books[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FullBacaanPage(
                    title: book['title']!,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      book['image']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        Text(
                          book['title']!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          book['author']!,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}