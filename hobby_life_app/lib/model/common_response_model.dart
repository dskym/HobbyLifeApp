class CommonResponseModel<T> {
  final int code;
  final String message;
  final T? data;

  CommonResponseModel({required this.code, required this.message, required this.data});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      code: json['code'],
      message: json['message'],
      data: json['data'],
    );
  }
}