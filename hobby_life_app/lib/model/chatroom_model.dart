import 'package:freezed_annotation/freezed_annotation.dart';

part 'chatroom_model.freezed.dart';
part 'chatroom_model.g.dart';

@freezed
class ChatroomModel with _$ChatroomModel {
  factory ChatroomModel({
    required int chatroomId,
    required String name,
    required String description,
    required bool isJoin,
  }) = _ChatroomModel;

  factory ChatroomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatroomModelFromJson(json);
}