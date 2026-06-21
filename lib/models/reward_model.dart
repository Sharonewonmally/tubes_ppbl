class RewardModel {
  final int id;
  final int userId;
  final String namaReward;
  final int poinDigunakan;
  final String status;
  final DateTime createdAt;

  RewardModel({
    required this.id,
    required this.userId,
    required this.namaReward,
    required this.poinDigunakan,
    required this.status,
    required this.createdAt,
  });

  factory RewardModel.fromMap(Map<String, dynamic> map) {
    return RewardModel(
      id: map['id'],
      userId: map['user_id'],
      namaReward: map['nama_reward'],
      poinDigunakan: map['poin_digunakan'],
      status: map['status'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'nama_reward': namaReward,
      'poin_digunakan': poinDigunakan,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}