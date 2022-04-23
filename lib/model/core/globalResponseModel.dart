class GlobalResponseModel {
  GlobalResponseModel({
    this.errorMessage,
    required this.error,
    required this.results,
  });

  dynamic errorMessage;
  bool error;
  dynamic results;

  factory GlobalResponseModel.fromJson(Map<String, dynamic> json) =>
      GlobalResponseModel(
        errorMessage: json["errorMessage"],
        error: json["error"] == null ? null : json["error"],
        results: json["results"] == null ? null : json["results"],
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "error": error == null ? null : error,
        "results": results == null ? null : results,
      };
}
