import 'package:freezed_annotation/freezed_annotation.dart';

part 'hobby_model.freezed.dart';
part 'hobby_model.g.dart';

@freezed
class HobbyModel with _$HobbyModel {
  factory HobbyModel({
    required String id,
    required String name,
  }) = _HobbyModel;

  factory HobbyModel.fromJson(Map<String, dynamic> json) =>
      _$HobbyModelFromJson(json);
}