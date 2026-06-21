import 'package:flutter/material.dart';
import 'database_helper.dart';

class TulisBukuPage extends StatefulWidget {
  const TulisBukuPage({super.key});

  @override
  State<TulisBukuPage> createState() => _TulisBukuPageState();
}

class _TulisBukuPageState extends State<TulisBukuPage> {

  final judulController = TextEditingController();
final isiController = TextEditingController();

String selectedGenre = "Novel";

String selectedImage = "assets/cover/BST.jpeg";


final List<String> genreList = [
  "Novel",
  "Fantasi",
  "Horor",
  "Romance",
  "Misteri",
  "Komedi"
];


final List<String> imageList = [
  "assets/cover/BST.jpeg",
  "assets/cover/bumi.jpeg",
  "assets/cover/hujan.jpeg",
];


  Future<void> simpanBuku() async {

    if(judulController.text.isEmpty ||
       isiController.text.isEmpty){

      ScaffoldMessenger.of(context)
      .showSnackBar(
        const SnackBar(
          content: Text(
            "Judul dan isi buku harus diisi"
          ),
        ),
      );

      return;
    }


    await DatabaseHelper.tambahBukuUser(
  judulController.text,
  selectedGenre,
  isiController.text,
  selectedImage,
);


    ScaffoldMessenger.of(context)
    .showSnackBar(
      const SnackBar(
        content: Text(
          "Buku berhasil diterbitkan 📖"
        ),
      ),
    );


    Navigator.pop(context, true);

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Tulis Buku"
        ),
      ),


      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [


            TextField(
              controller: judulController,

              decoration: const InputDecoration(

                labelText: "Judul Buku",

                border: OutlineInputBorder(),

              ),

            ),


            const SizedBox(height:15),



            DropdownButtonFormField(

              value: selectedGenre,

              decoration: const InputDecoration(

                labelText: "Genre",

                border: OutlineInputBorder(),

              ),


              items: genreList.map((genre){

                return DropdownMenuItem(

                  value: genre,

                  child: Text(genre),

                );

              }).toList(),


              onChanged: (value){

                setState(() {

                  selectedGenre = value.toString();

                });

              },

            ),



            const SizedBox(height:15),



            TextField(

              controller: isiController,

              maxLines: 10,


              decoration: const InputDecoration(

                labelText: "Isi Buku",

                alignLabelWithHint: true,

                border: OutlineInputBorder(),

              ),

            ),



            const SizedBox(height:15),



            DropdownButtonFormField(

  value: selectedImage,

  decoration: const InputDecoration(

    labelText: "Cover Buku",

    border: OutlineInputBorder(),

  ),


  items: imageList.map((gambar){

    return DropdownMenuItem(

      value: gambar,

      child: Row(

        children: [

          Image.asset(
            gambar,
            width: 40,
            height: 50,
            fit: BoxFit.cover,
          ),


          const SizedBox(width:10),


          Text(gambar),

        ],

      ),

    );

  }).toList(),



  onChanged: (value){

    setState(() {

      selectedImage = value!;

    });

  },

),



            const SizedBox(height:25),



            SizedBox(

              width: double.infinity,


              child: ElevatedButton(

                onPressed: simpanBuku,


                child: const Text(

                  "Terbitkan Buku"

                ),

              ),

            )


          ],

        ),

      ),

    );

  }
}