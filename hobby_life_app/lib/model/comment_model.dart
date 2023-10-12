class CommentModel {
  final int commentId;
  final String detail;
  final int authorId;
  final int contentId;
  final int originalCommentId;

  CommentModel({required this.commentId, required this.detail, required this.authorId, required this.contentId, required this.originalCommentId});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      commentId: json['commentId'],
      detail: json['detail'],
      authorId: json['authorId'],
      contentId: json['contentId'],
      originalCommentId: json['originalCommentId'],
    );
  }
}