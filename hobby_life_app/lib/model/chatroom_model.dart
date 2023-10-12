class ChatroomModel {
  final int chatroomId;
  final String name;
  final String description;

  ChatroomModel({required this.chatroomId, required this.name, required this.description});

  factory ChatroomModel.fromJson(Map<String, dynamic> json) {
    return ChatroomModel(
      chatroomId: json['chatroomId'],
      name: json['name'],
      description: json['description'],
    );
  }
}