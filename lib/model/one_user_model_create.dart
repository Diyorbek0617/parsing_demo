import 'package:parsing_demo/model/user_model.dart';

class User_create {
  String status;
  String message;
  User data;

  User_create.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        message = json['message'],
        data = User.fromJson(json['data']);

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };

}