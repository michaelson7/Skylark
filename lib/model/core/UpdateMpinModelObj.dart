class UpdateMpinModelObj {
  String oldmpin, newmpin, confirmmpin;

  UpdateMpinModelObj({
    required this.oldmpin,
    required this.newmpin,
    required this.confirmmpin,
  });
}

class UpdateMpinModel {
  UpdateMpinModel({
    required this.responseCode,
    required this.message,
    this.notifications,
    this.errors,
  });

  String responseCode;
  String message;
  List<Notification>? notifications;
  Errors? errors;

  factory UpdateMpinModel.fromJson(Map<String, dynamic> json) =>
      UpdateMpinModel(
        responseCode: json["responseCode"],
        message: json["message"],
        errors: json["errors"] != null ? Errors.fromJson(json["errors"]) : null,
        notifications: json["notifications"] != null
            ? List<Notification>.from(
                json["notifications"].map((x) => Notification.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "message": message,
        "errors": errors != null ? errors?.toJson() : null,
        "notifications": notifications != null
            ? List<dynamic>.from(notifications!.map((x) => x.toJson()))
            : null,
      };
}

class Notification {
  Notification({
    required this.notificationCode,
    required this.message,
  });

  String notificationCode;
  String message;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        notificationCode: json["notificationCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "notificationCode": notificationCode,
        "message": message,
      };
}

class Errors {
  Errors({
    required this.errorCode,
    required this.message,
  });

  String errorCode;
  String message;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        errorCode: json["errorCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "message": message,
      };
}
