import 'user_model.dart';

class MainResponse {
  final String message;
  final List<UserModel> data;
  const MainResponse({required this.message, required this.data});

  factory MainResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> dataJson = json['data'];
    return MainResponse(
        message: json['message'],
        data: dataJson.map((user) => UserModel.fromJson(user)).toList());
  }
}
