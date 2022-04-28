import 'dart:convert';
import 'package:skylark/model/core/BookingModel.dart';
import 'package:skylark/model/service/dataAccess.dart';
import '../../view/widgets/loggerWidget.dart';
import '../core/UsersModel.dart';

String baseUrl = "192.168.43.90:3090";
String imageLink = "http://192.168.43.90:3069/Images/";

class Api {
  //Bookings
  Future<dynamic> bookingsCreate({
    bool showResponse = false,
    required BookingModelObj model,
  }) async {
    final body = {
      "userId": model.userId,
      "serviceId": model.serviceId,
      "modelId": model.modelId,
      "bookingDate": model.bookingDate?.toIso8601String(),
    };
    Uri uri = Uri.http(baseUrl, "createBookings");
    displayUriInLogger(
      shouldDisplayInLogger: showResponse,
      Uri: uri.toString(),
    );
    return await postResponse(uri, body);
  }

  Future<dynamic> bookingGetByID(
      {bool showResponse = false, required int userId}) async {
    var urlPath = '/getAllBookingsById';
    final requestParameters = {"userId": userId.toString()};
    Uri uri = Uri.http(baseUrl, urlPath, requestParameters);
    displayUriInLogger(
      shouldDisplayInLogger: showResponse,
      Uri: uri.toString(),
    );
    return await getResponse(uri);
  }

  Future<dynamic> bookingDelete({
    bool showResponse = false,
    required int id,
  }) async {
    var urlPath = '/deleteBookings';
    final requestParameters = {"id": id.toString()};
    Uri uri = Uri.http(baseUrl, urlPath, requestParameters);
    displayUriInLogger(
      shouldDisplayInLogger: showResponse,
      Uri: uri.toString(),
    );
    return await getResponse(uri);
  }

  //Users
  Future<dynamic> usersCreate({
    bool showResponse = false,
    required UsersModel model,
  }) async {
    final body = {
      "names": model.names,
      "email": model.email,
      "password": model.password,
      "accountTypeId": model.accountTypeId,
    };
    Uri uri = Uri.http(baseUrl, "createUsers");
    displayUriInLogger(
      shouldDisplayInLogger: showResponse,
      Uri: uri.toString(),
    );
    return await postResponse(uri, body);
  }

  Future<dynamic> usersLogin({
    bool showResponse = false,
    required UsersModel model,
  }) async {
    final body = {
      "email": model.email,
      "password": model.password,
    };
    Uri uri = Uri.http(baseUrl, "loginUser");
    displayUriInLogger(
      shouldDisplayInLogger: showResponse,
      Uri: uri.toString(),
    );
    return await postResponse(uri, body);
  }

  //------------------------------------------------------------------------------global requests
  Future<dynamic> dynamicGetAll({
    bool showResponse = false,
    required endpoint,
  }) async {
    Uri uri = Uri.http(baseUrl, endpoint);
    displayUriInLogger(
      shouldDisplayInLogger: showResponse,
      Uri: uri.toString(),
    );
    return await getResponse(uri);
  }

  void displayUriInLogger({bool shouldDisplayInLogger = false, dynamic Uri}) {
    if (shouldDisplayInLogger) {
      loggerInfo(message: "URI: $Uri");
    }
  }
}
