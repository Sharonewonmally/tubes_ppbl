import 'package:flutter/material.dart';

import 'database_helper.dart';
import 'full_bacaan_page.dart';
import 'models/favorite_book.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({super.key});

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {

  List<Map<String, dynamic>> books = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {

  books = await DatabaseHelper.getBooks();

  setState(() {
    loading = false;
  });
}

  Future<void> tambahKeFavorite(
    Map<String, dynamic> book,
  ) async {
    final sudahAda = await DatabaseHelper.cekFavorite(
      book['title'],
    );

    if (sudahAda) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Buku sudah ada di favorit ❤️",
          ),
        ),
      );
      return;
    }

    await DatabaseHelper.tambahFavorite(
      FavoriteBook(
        title: book['title'],
        author: book['author'],
        imagePath: book['imagePath'],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${book['title']} berhasil ditambahkan ❤️",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Genre Buku",
        ),
        centerTitle: true,
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),

        itemCount: books.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.55,
        ),

        itemBuilder: (context, index) {

          final book = books[index];

          return Card(
            elevation: 3,

            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12),
            ),

            clipBehavior:
                Clip.antiAlias,

            child: InkWell(

              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        FullBacaanPage(
                      title:
                          book['title'],
                    ),
                  ),
                );

              },


              child: Column(
                children: [

                  Expanded(

                    child: Stack(

                      children: [

                        Positioned.fill(

                          child: Image.asset(
                            book['imagePath'],
                            fit: BoxFit.cover,
                          ),

                        ),


                        Positioned(

                          top: 5,
                          right: 5,


                          child: CircleAvatar(

                            radius: 16,

                            backgroundColor:
                                Colors.white,


                            child: IconButton(

                              padding:
                                  EdgeInsets.zero,


                              icon:
                                  const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 18,
                              ),


                              onPressed: () {

                                tambahKeFavorite(
                                  book,
                                );

                              },

                            ),

                          ),

                        ),

                      ],

                    ),

                  ),



                  Padding(

                    padding:
                        const EdgeInsets.all(6),


                    child: Column(

                      children: [

                        Text(

                          book['title'],

                          maxLines: 2,

                          overflow:
                              TextOverflow.ellipsis,

                          textAlign:
                              TextAlign.center,


                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight.bold,

                            fontSize: 11,

                          ),

                        ),


                        const SizedBox(
                          height: 3,
                        ),



                        Text(

                          book['author'],

                          maxLines: 1,

                          overflow:
                              TextOverflow.ellipsis,


                          textAlign:
                              TextAlign.center,


                          style:
                              const TextStyle(

                            color:
                                Colors.grey,

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