import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'database_helper.dart';

class UlasanPage extends StatefulWidget {
  final String title;

  const UlasanPage({
    super.key,
    required this.title,
  });

  @override
  State<UlasanPage> createState() => _UlasanPageState();
}


class _UlasanPageState extends State<UlasanPage> {

  double rating = 0;

  final TextEditingController komentarController =
  TextEditingController();


  Future<void> kirimUlasan() async {

    if (rating == 0 ||
        komentarController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Rating dan komentar wajib diisi",
          ),
        ),
      );

      return;
    }

    final db =
    await DatabaseHelper.getDatabase();

    await db.insert(
      'ulasan',
      {
        'judul_buku': widget.title,
        'rating': rating,
        'komentar': komentarController.text,
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Ulasan berhasil dikirim",
        ),
      ),
    );

    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Berikan Ulasan",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

      ),



      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(16),


          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,


            children: [


              Text(

                widget.title,

                style: const TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 20),



              const Text(

                "Berikan Rating",

                style: TextStyle(

                  fontSize: 17,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 10),



              Center(

                child: RatingBar.builder(


                  initialRating: 0,


                  minRating: 1,


                  allowHalfRating: true,


                  itemCount: 5,


                  itemSize: 38,


                  itemBuilder: (context, index) {


                    return const Icon(

                      Icons.star,

                      color: Colors.amber,

                    );


                  },


                  onRatingUpdate: (value) {


                    setState(() {

                      rating = value;

                    });


                  },


                ),

              ),



              const SizedBox(height: 20),



              const Text(

                "Komentar",

                style: TextStyle(

                  fontSize: 17,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 8),



              TextField(

                controller: komentarController,


                maxLines: 4,


                decoration: InputDecoration(

                  hintText:
                  "Tulis pendapat kamu tentang buku ini",


                  border: OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(15),

                  ),

                ),

              ),


              SizedBox(

                width: double.infinity,


                height: 45,


                child: ElevatedButton(


                  onPressed: kirimUlasan,


                  style: ElevatedButton.styleFrom(


                    shape: RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(15),

                    ),

                  ),


                  child: const Text(

                    "Kirim Ulasan",


                    style: TextStyle(

                      fontSize: 15,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

              ),


            ],

          ),

        ),

      ),

    );

  }


  @override
  void dispose() {

    komentarController.dispose();

    super.dispose();

  }

}