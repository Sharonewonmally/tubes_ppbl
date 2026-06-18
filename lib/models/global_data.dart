class UserModel {

  final int id;
  final String username;
  final String socialMedia;
  final String fotoProfil;

  UserModel({
    required this.id,
    required this.username,
    required this.socialMedia,
    required this.fotoProfil,
  });

  factory UserModel.fromMap(
      Map<String, dynamic> map) {

    return UserModel(
      id: map['id'],
      username: map['username'],
      socialMedia: map['social_media'],
      fotoProfil: map['foto_profil'],
    );
  }
}