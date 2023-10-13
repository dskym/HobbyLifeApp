import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_auth_model.freezed.dart';
part 'user_auth_model.g.dart';

@freezed
class UserAuthModel with _$UserAuthModel {
  factory UserAuthModel({
    required String accessToken,
    required String refreshToken,
  }) = _UserAuthModel;

  factory UserAuthModel.fromJson(Map<String, dynamic> json) =>
      _$UserAuthModelFromJson(json);
}