class CommunityModel {
  final String communityId;
  final String title;
  final String description;
  final int authorId;
  final int hobbyId;

  CommunityModel({required this.communityId, required this.title, required this.description, required this.authorId, required this.hobbyId});

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      communityId: json['communityId'],
      title: json['title'],
      description: json['description'],
      authorId: json['authorId'],
      hobbyId: json['hobbyId'],
    );
  }
}