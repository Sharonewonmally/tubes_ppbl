class UserModel {
  final int id;
  final String username;
  final String socialMedia;
  final String fotoProfil;
  final int points;

  UserModel({
    required this.id,
    required this.username,
    required this.socialMedia,
    required this.fotoProfil,
    required this.points,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      username: map['username'] ?? '',
      socialMedia: map['social_media'] ?? '',
      fotoProfil: map['foto_profil'] ?? '',
      points: map['points'] ?? 0,
    );
  }
}