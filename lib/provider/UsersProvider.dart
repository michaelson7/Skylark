import 'package:flutter/material.dart';
import 'package:skylark/model/core/globalResponseModel.dart';
import '../model/core/LoginResponseModel.dart';
import '../model/core/UsersModel.dart';
import '../model/service/ApiHelper.dart';
import 'SharedPreferenceProvider.dart';

class UsersProvider extends ChangeNotifier {
  final _apiHelper = ApiHelper();
  SharedPreferenceProvider sp = SharedPreferenceProvider();

  Future<GlobalResponseModel?> usersCreate({
    bool showResponse = false,
    required UsersModel model,
  }) async {
    var result = await _apiHelper.usersCreate(
      showResponse: showResponse,
      model: model,
    );
    if (!result!.error) {
      sp.addUserData(model);
    }
    return result;
  }

  Future<LoginResponseModel?> usersLogin({
    bool showResponse = false,
    required UsersModel model,
  }) async {
    var result = await _apiHelper.usersLogin(
      showResponse: showResponse,
      model: model,
    );
    if (!result!.error) {
      sp.addUserData(result.results!);
    }
    return result;
  }
}
