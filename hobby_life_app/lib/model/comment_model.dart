import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_model.freezed.dart';
part 'comment_model.g.dart';

@freezed
class CommentModel with _$CommentModel {
  factory CommentModel({
    required int commentId,
    required String detail,
    required int authorId,
    required int contentId,
    required int originalCommentId,
  }) = _CommentModel;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
}