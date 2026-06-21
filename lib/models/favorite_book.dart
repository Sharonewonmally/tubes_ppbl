class FavoriteBook {
  final int? id;
  final String title;
  final String author;
  final String imagePath;

  FavoriteBook({
    this.id,
    required this.title,
    required this.author,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imagePath': imagePath,
    };
  }

  factory FavoriteBook.fromMap(
    Map<String, dynamic> map,
  ) {
    return FavoriteBook(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      imagePath: map['imagePath'],
    );
  }
}