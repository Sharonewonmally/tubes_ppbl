class Book {

  final int id;
  final String title;
  final String author;
  final String content;
  final String image;
  final String genre;
  final int premiumPoint;


  Book({

    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.image,
    required this.genre,
    required this.premiumPoint,

  });



  factory Book.fromMap(Map<String,dynamic> map){

    return Book(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      content: map['content'] ?? '',
      image: map['imagePath'] ?? '',
      genre: map['genre'] ?? '',
      premiumPoint: map['premium_point'] ?? 0,

    );

  }



  Map<String,dynamic> toMap(){

    return {
      'id':id,
      'title':title,
      'author':author,
      'content':content,
      'imagePath':image,
      'genre':genre,
      'premium_point':premiumPoint,
    };
  }
}