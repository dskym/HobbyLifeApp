import 'package:freezed_annotation/freezed_annotation.dart';

part 'hobby_history_model.freezed.dart';
part 'hobby_history_model.g.dart';

@freezed
class HobbyHistoryModel with _$HobbyHistoryModel {
  factory HobbyHistoryModel({
    required int id,
    required int score,
    required int cost,
    required DateTime hobbyDate,
    required String hobbyName,
  }) = _HobbyHistoryModel;

  factory HobbyHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HobbyHistoryModelFromJson(json);
}
