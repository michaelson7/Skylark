import '../service/Api.dart';

class ModelsModel {
  ModelsModel({
    this.errorMessage,
    required this.error,
    this.results,
  });

  dynamic errorMessage;
  bool error;
  List<ModelsModelObj>? results;

  factory ModelsModel.fromJson(Map<String, dynamic> json) => ModelsModel(
        errorMessage: json["errorMessage"],
        error: json["error"] == null ? null : json["error"],
        results: json["results"] == null
            ? null
            : List<ModelsModelObj>.from(
                json["results"].map((x) => ModelsModelObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "error": error == null ? null : error,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ModelsModelObj {
  ModelsModelObj({required this.id, required this.title, this.imagePath});

  int id;
  String title;
  String? imagePath;

  factory ModelsModelObj.fromJson(Map<String, dynamic> json) => ModelsModelObj(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        imagePath:
            json["imagePath"] == null ? null : imageLink + json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "imagePath": imagePath == null ? null : imagePath,
      };
}
