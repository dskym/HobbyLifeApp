class ContentModel {
  final String contentId;
  final String title;
  final String description;
  final int authorId;
  final int communityId;

  ContentModel({required this.contentId, required this.title, required this.description, required this.authorId, required this.communityId});

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      contentId: json['contentId'],
      title: json['title'],
      description: json['description'],
      authorId: json['authorId'],
      communityId: json['communityId'],
    );
  }
}