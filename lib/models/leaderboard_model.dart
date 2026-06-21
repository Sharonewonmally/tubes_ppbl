class LeaderboardModel {
  final int id;
  final String username;
  final String? fotoProfil;
  final int points;

  LeaderboardModel({
    required this.id,
    required this.username,
    this.fotoProfil,
    required this.points,
  });

  factory LeaderboardModel.fromMap(Map<String, dynamic> map) {
    return LeaderboardModel(
      id: map['id'],
      username: map['username'],
      fotoProfil: map['foto_profil'],
      points: map['points'],
    );
  }
}