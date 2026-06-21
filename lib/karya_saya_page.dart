import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'full_bacaan_page.dart';


class KaryaSayaPage extends StatefulWidget {
  const KaryaSayaPage({super.key});

  @override
  State<KaryaSayaPage> createState() => _KaryaSayaPageState();
}


class _KaryaSayaPageState extends State<KaryaSayaPage> {


  List<Map<String,dynamic>> buku = [];

  bool loading = true;


  @override
  void initState() {
    super.initState();
    loadBuku();
  }


  Future<void> loadBuku() async {

    buku = await DatabaseHelper.ambilBukuUser();


    setState(() {
      loading = false;
    });

  }



  @override
  Widget build(BuildContext context) {


    if(loading){

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),

      );

    }


    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Karya Saya",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

      ),



      body: buku.isEmpty

      ? const Center(

        child: Text(
          "Belum ada buku yang dibuat",
          style: TextStyle(
            fontSize: 16,
          ),
        ),

      )


      : GridView.builder(

        padding: const EdgeInsets.all(12),


        itemCount: buku.length,


        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(

          crossAxisCount: 2,

          crossAxisSpacing: 12,

          mainAxisSpacing: 12,

          childAspectRatio: 0.6,

        ),



        itemBuilder: (context,index){


          final item = buku[index];



          return Card(

            elevation: 4,


            shape: RoundedRectangleBorder(

              borderRadius:
              BorderRadius.circular(15),

            ),



            clipBehavior:
            Clip.antiAlias,



            child: InkWell(


              onTap: (){


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_)=>

                    FullBacaanPage(

                      title:
                      item['judul'],

                    ),

                  ),

                );


              },



              child: Column(

                children: [



                  Expanded(

                    child: Image.asset(

                      item['gambar'],

                      fit: BoxFit.cover,



                      errorBuilder:
                      (context,error,stackTrace){

                        return const Icon(
                          Icons.book,
                          size:80,
                        );

                      },

                    ),

                  ),



                  Padding(

                    padding:
                    const EdgeInsets.all(8),


                    child: Column(

                      children: [


                        Text(

                          item['judul'],

                          maxLines:2,

                          overflow:
                          TextOverflow.ellipsis,


                          textAlign:
                          TextAlign.center,


                          style:
                          const TextStyle(

                            fontWeight:
                            FontWeight.bold,

                          ),

                        ),



                        const SizedBox(
                          height:5,
                        ),



                        Text(

                          item['genre'],

                          style:
                          const TextStyle(

                            color: Colors.grey,

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