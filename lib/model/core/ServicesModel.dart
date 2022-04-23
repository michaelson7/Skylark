import '../service/Api.dart';
import 'UsersModel.dart';

class ServiceModel {
  ServiceModel({
    this.errorMessage,
    required this.error,
    this.results,
  });

  dynamic errorMessage;
  bool error;
  List<ServicesModelObj>? results;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        errorMessage: json["errorMessage"],
        error: json["error"] == null ? null : json["error"],
        results: json["results"] == null
            ? null
            : List<ServicesModelObj>.from(
                json["results"].map((x) => ServicesModelObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "error": error == null ? null : error,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ServicesModelObj {
  ServicesModelObj({
    required this.id,
    required this.title,
    required this.description,
    required this.cost,
    this.imagePath,
    required this.uploaderId,
    this.timestamp,
    this.usersModel,
  });

  int id;
  String title;
  String description;
  int cost;
  String? imagePath;
  int uploaderId;
  DateTime? timestamp;
  UsersModel? usersModel;

  factory ServicesModelObj.fromJson(Map<String, dynamic> json) {
    return ServicesModelObj(
      id: json["id"] == null ? null : json["id"],
      title: json["title"] == null ? null : json["title"],
      description: json["description"] == null ? null : json["description"],
      cost: json["cost"] == null ? null : json["cost"],
      imagePath:
          json["imagePath"] == null ? null : imageLink + json["imagePath"],
      uploaderId: json["uploaderID"] == null ? null : json["uploaderID"],
      timestamp:
          json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
      usersModel: json["usersModel"] == null
          ? null
          : UsersModel.fromJson(json["usersModel"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "cost": cost == null ? null : cost,
        "imagePath": imagePath == null ? null : imagePath,
        "uploaderID": uploaderId == null ? null : uploaderId,
        "timestamp": timestamp == null ? null : timestamp?.toIso8601String(),
        "usersModel": usersModel == null ? null : usersModel?.toJson(),
      };
}
