import 'package:freezed_annotation/freezed_annotation.dart';

part 'hobby_history_model.freezed.dart';
part 'hobby_history_model.g.dart';

@freezed
class HobbyHistoryModel with _$HobbyHistoryModel {
  factory HobbyHistoryModel({
    required int id,
    required String name,
    required String hobbyDate,
    required String startTime,
    required String endTime,
    required int categoryId,
    required int? score,
    required int? cost,
    required String? memo,
  }) = _HobbyHistoryModel;

  factory HobbyHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HobbyHistoryModelFromJson(json);
}
