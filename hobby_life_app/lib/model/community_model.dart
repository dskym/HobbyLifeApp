import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_model.freezed.dart';
part 'community_model.g.dart';

@freezed
class CommunityModel with _$CommunityModel {
  factory CommunityModel({
    required int communityId,
    required String title,
    required String description,
    required int authorId,
    required String categoryName,
    required int memberCount,
  }) = _CommunityModel;

  factory CommunityModel.fromJson(Map<String, dynamic> json) =>
      _$CommunityModelFromJson(json);
}