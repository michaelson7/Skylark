import 'package:skylark/model/core/BookingModel.dart';
import 'package:skylark/model/core/ModelsModel.dart';
import 'package:skylark/model/core/ServicesModel.dart';
import 'package:skylark/model/core/UsersModel.dart';
import '../../view/widgets/loggerWidget.dart';
import '../core/LoginResponseModel.dart';
import '../core/UpdateMpinModelObj.dart';
import '../core/globalResponseModel.dart';
import 'Api.dart';

class ApiHelper {
  Api api = Api();

  Future<GlobalResponseModel?> bookingsCreate({
    bool showResponse = false,
    required BookingModelObj model,
  }) async {
    try {
      GlobalResponseModel response;
      var jsonResponse = await api.bookingsCreate(
        model: model,
        showResponse: showResponse,
      );
      response = GlobalResponseModel.fromJson(jsonResponse);
      displayJsonInLogger(
        shouldDisplayInLogger: showResponse,
        jsonFile: response.toJson().toString(),
      );
      return response;
    } catch (e) {
      throw Exception(getError(e, 'bookingsCreate'));
    }
  }

  Future<BookingModel> bookingsGetAll({bool showResponse = false}) async {
    try {
      BookingModel response;
      var jsonResponse = await api.dynamicGetAll(
        endpoint: "getAllBookings",
        showResponse: showResponse,
      );
      response = BookingModel.fromJson(jsonResponse);
      displayJsonInLogger(
        shouldDisplayInLogger: showResponse,
        jsonFile: response.toJson().toString(),
      );
      return response;
    } catch (e) {
      throw Exception(getError(e, 'getAllBookings'));
    }
  }

  //models
  Future<ModelsModel> modelsGetAll({bool showResponse = false}) async {
    try {
      ModelsModel response;
      var jsonResponse = await api.dynamicGetAll(
        endpoint: "getAllModels",
        showResponse: showResponse,
      );
      response = ModelsModel.fromJson(jsonResponse);
      displayJsonInLogger(
        shouldDisplayInLogger: showResponse,
        jsonFile: response.toJson().toString(),
      );
      return response;
    } catch (e) {
      throw Exception(getError(e, 'getAllModels'));
    }
  }

  //Serices
  Future<ServiceModel> servicesGetAll({bool showResponse = false}) async {
    try {
      ServiceModel response;
      var jsonResponse = await api.dynamicGetAll(
        endpoint: "getAllServices",
        showResponse: showResponse,
      );
      response = ServiceModel.fromJson(jsonResponse);
      displayJsonInLogger(
        shouldDisplayInLogger: showResponse,
        jsonFile: response.toJson().toString(),
      );
      return response;
    } catch (e) {
      throw Exception(getError(e, 'getAllServices'));
    }
  }

  //
  Future<GlobalResponseModel?> usersCreate({
    bool showResponse = false,
    required UsersModel model,
  }) async {
    try {
      GlobalResponseModel response;
      var jsonResponse = await api.usersCreate(
        model: model,
        showResponse: showResponse,
      );
      response = GlobalResponseModel.fromJson(jsonResponse);
      displayJsonInLogger(
        shouldDisplayInLogger: showResponse,
        jsonFile: response.toJson().toString(),
      );
      return response;
    } catch (e) {
      throw Exception(getError(e, 'usersCreate'));
    }
  }

  Future<LoginResponseModel?> usersLogin({
    bool showResponse = false,
    required UsersModel model,
  }) async {
    try {
      LoginResponseModel response;
      var jsonResponse = await api.usersLogin(
        model: model,
        showResponse: showResponse,
      );
      response = LoginResponseModel.fromJson(jsonResponse);
      displayJsonInLogger(
        shouldDisplayInLogger: showResponse,
        jsonFile: response.toJson().toString(),
      );
      return response;
    } catch (e) {
      throw Exception(getError(e, 'usersLogin'));
    }
  }

  //---------------------------------------------------------------------------------------------------------------------------display json
  void displayJsonInLogger({
    bool shouldDisplayInLogger = false,
    dynamic jsonFile,
  }) {
    if (shouldDisplayInLogger) {
      loggerInfo(message: "JSON RESPONSE: $jsonFile");
    }
  }

  String getError(errorMessage, src) {
    var message = 'Error while passing to $src: $errorMessage';
    loggerError(message: message);
    return message;
  }
}
