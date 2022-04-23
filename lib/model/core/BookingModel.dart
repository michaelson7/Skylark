import 'ModelsModel.dart';
import 'ServicesModel.dart';
import 'UsersModel.dart';

class BookingModel {
  BookingModel({
    this.errorMessage,
    required this.error,
    this.results,
  });

  dynamic errorMessage;
  bool error;
  List<BookingModelObj>? results;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        errorMessage: json["errorMessage"],
        error: json["error"] == null ? null : json["error"],
        results: json["results"] == null
            ? null
            : List<BookingModelObj>.from(
                json["results"].map((x) => BookingModelObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "error": error == null ? null : error,
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class BookingModelObj {
  BookingModelObj({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.modelId,
    this.timestamp,
    this.bookingDate,
    this.servicesModel,
    this.usersModel,
    this.modelsModel,
  });

  int id;
  int userId;
  int serviceId;
  int modelId;
  DateTime? timestamp;
  DateTime? bookingDate;
  ServicesModelObj? servicesModel;
  UsersModel? usersModel;
  ModelsModelObj? modelsModel;

  factory BookingModelObj.fromJson(Map<String, dynamic> json) =>
      BookingModelObj(
        id: json["id"] == null ? null : json["id"],
        userId: json["userId"] == null ? null : json["userId"],
        serviceId: json["serviceId"] == null ? null : json["serviceId"],
        modelId: json["modelId"] == null ? null : json["modelId"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        bookingDate: json["bookingDate"] == null
            ? null
            : DateTime.parse(json["bookingDate"]),
        servicesModel: json["servicesModel"] == null
            ? null
            : ServicesModelObj.fromJson(json["servicesModel"]),
        usersModel: json["usersModel"] == null
            ? null
            : UsersModel.fromJson(json["usersModel"]),
        modelsModel: json["modelsModel"] == null
            ? null
            : ModelsModelObj.fromJson(json["modelsModel"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userId": userId == null ? null : userId,
        "serviceId": serviceId == null ? null : serviceId,
        "modelId": modelId == null ? null : modelId,
        "timestamp": timestamp == null ? null : timestamp?.toIso8601String(),
        "bookingDate":
            bookingDate == null ? null : bookingDate?.toIso8601String(),
        "servicesModel": servicesModel == null ? null : servicesModel?.toJson(),
        "usersModel": usersModel == null ? null : usersModel?.toJson(),
        "modelsModel": modelsModel == null ? null : modelsModel?.toJson(),
      };
}
