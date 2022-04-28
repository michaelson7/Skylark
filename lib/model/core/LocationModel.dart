class LocationModel {
  LocationModel({
    this.errorMessage,
    required this.error,
    required this.results,
  });

  dynamic errorMessage;
  bool error;
  List<LocationModelObj> results;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        errorMessage: json["errorMessage"],
        error: json["error"],
        results: List<LocationModelObj>.from(
            json["results"].map((x) => LocationModelObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "error": error,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class LocationModelObj {
  LocationModelObj({
    required this.id,
    required this.title,
    required this.longitude,
    required this.latitude,
  });

  int id;
  String title;
  String longitude;
  String latitude;

  factory LocationModelObj.fromJson(Map<String, dynamic> json) =>
      LocationModelObj(
        id: json["id"],
        title: json["title"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "longitude": longitude,
        "latitude": latitude,
      };
}
