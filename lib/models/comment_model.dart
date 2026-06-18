class CommentModel {
  int? id;
  String username;
  String pesan;

  CommentModel({
    this.id,
    required this.username,
    required this.pesan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'pesan': pesan,
    };
  }

  factory CommentModel.fromMap(
      Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      username: map['username'],
      pesan: map['pesan'],
    );
  }
}