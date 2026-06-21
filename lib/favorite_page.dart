import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'database_helper.dart';
import '../models/favorite_book.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  
  List<FavoriteBook> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    setState(() {
      isLoading = true;
    });

    final data =await DatabaseHelper.ambilSemuaFavorite();

    print("JUMLAH FAVORIT: ${data.length}");

    setState(() {
      favorites = data;
      isLoading = false;
    });
  }

  Future<void> hapusFavorite(int id) async {
    await DatabaseHelper.hapusFavorite(id);
    await loadFavorites();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Buku berhasil dihapus",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Buku Favorit",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: loadFavorites,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : favorites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Belum ada buku favorit",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Tambahkan buku dari halaman Genre",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: favorites.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final book = favorites[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.asset(
                                book.imagePath,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.menu_book,
                                      size: 50,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          Padding(
                            padding:
                                const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  book.title,
                                  textAlign:
                                      TextAlign.center,
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style:
                                      GoogleFonts.poppins(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  book.author,
                                  textAlign:
                                      TextAlign.center,
                                  style:
                                      GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                SizedBox(
                                  width: double.infinity,
                                  child:
                                      ElevatedButton.icon(
                                    onPressed: () {
                                      hapusFavorite(
                                        book.id!,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                    ),
                                    label: const Text(
                                      "Hapus",
                                    ),
                                    style:
                                        ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red,
                                      foregroundColor:
                                          Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}