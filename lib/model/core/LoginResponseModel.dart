import 'package:skylark/model/core/UsersModel.dart';

class LoginResponseModel {
  LoginResponseModel({
    this.errorMessage,
    required this.error,
    this.results,
  });

  dynamic errorMessage;
  bool error;
  UsersModel? results;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        errorMessage: json["errorMessage"],
        error: json["error"] == null ? null : json["error"],
        results: json["results"] == null
            ? null
            : UsersModel.fromJson(json["results"]),
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "error": error == null ? null : error,
        "results": results == null ? null : results?.toJson(),
      };
}
