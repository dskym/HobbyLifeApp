class HobbyModel {
  final String id;
  final String name;

  HobbyModel({required this.id, required this.name});

  factory HobbyModel.fromJson(Map<String, dynamic> json) {
    return HobbyModel(
      id: json['id'],
      name: json['name'],
    );
  }
}