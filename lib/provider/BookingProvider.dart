import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skylark/model/core/globalResponseModel.dart';
import '../model/core/BookingModel.dart';
import '../model/core/UpdateMpinModelObj.dart';
import '../model/service/ApiHelper.dart';

class BookingProvider extends ChangeNotifier {
  final _apiHelper = ApiHelper();
  final _dataList = BehaviorSubject<List<BookingModelObj>?>();
  get providerList => _dataList.stream;

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

  Future<GlobalResponseModel?> bookingsDelete({
    bool showResponse = false,
    required int id,
  }) async {
    var result = await _apiHelper.bookingsDelete(
      showResponse: showResponse,
      id: id,
    );
    return result;
  }

  Future<BookingModel?> bookingsGetAll({bool showResponse = false}) async {
    var result = await _apiHelper.bookingsGetAll(
      showResponse: showResponse,
    );
    return result;
  }

  Future<BookingModel?> bookingGetByID({
    bool showResponse = false,
    required int userID,
  }) async {
    var result = await _apiHelper.bookingGetByID(
      showResponse: showResponse,
      userID: userID,
    );
    if (result.results != null) {
      _dataList.add(result.results);
    }
    return result;
  }
}
