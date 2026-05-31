class CommentModel {
  int? id;
  String username;
  String comment;

  CommentModel({
    this.id,
    required this.username,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'comment': comment,
    };
  }

  factory CommentModel.fromMap(
      Map<String, dynamic> map) {
    return CommentModel(
      id: map['id'],
      username: map['username'],
      comment: map['comment'],
    );
  }
}