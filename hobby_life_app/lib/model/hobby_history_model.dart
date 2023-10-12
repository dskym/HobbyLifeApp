class HobbyHistoryModel {
  final int id;
  final int score;
  final int cost;
  final DateTime hobbyDate;

  HobbyHistoryModel({required this.id, required this.score, required this.cost, required this.hobbyDate});

  factory HobbyHistoryModel.fromJson(Map<String, dynamic> json) {
    return HobbyHistoryModel(
      id: json['id'],
      score: json['score'],
      cost: json['cost'],
      hobbyDate: DateTime.parse(json['hobbyDate']),
    );
  }
}