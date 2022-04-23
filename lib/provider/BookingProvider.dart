import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skylark/model/core/globalResponseModel.dart';
import '../model/core/BookingModel.dart';
import '../model/core/UpdateMpinModelObj.dart';
import '../model/service/ApiHelper.dart';

class BookingProvider extends ChangeNotifier {
  final _apiHelper = ApiHelper();

  Future<GlobalResponseModel?> bookingsCreate({
    bool showResponse = false,
    required BookingModelObj model,
  }) async {
    var result = await _apiHelper.bookingsCreate(
      showResponse: showResponse,
      model: model,
    );
    return result;
  }

  Future<BookingModel?> bookingsGetAll({bool showResponse = false}) async {
    var result = await _apiHelper.bookingsGetAll(
      showResponse: showResponse,
    );
    return result;
  }
}
