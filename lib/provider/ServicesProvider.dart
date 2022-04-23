import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skylark/model/core/ModelsModel.dart';
import 'package:skylark/model/core/globalResponseModel.dart';
import '../model/core/BookingModel.dart';
import '../model/core/ServicesModel.dart';
import '../model/core/UpdateMpinModelObj.dart';
import '../model/service/ApiHelper.dart';

class ServicesProvider extends ChangeNotifier {
  final _apiHelper = ApiHelper();
  final _dataList = BehaviorSubject<List<ServicesModelObj>?>();

  get providerList => _dataList.stream;

  Future<ServiceModel?> getAllServices({bool showResponse = false}) async {
    var result = await _apiHelper.servicesGetAll(
      showResponse: showResponse,
    );
    if (result.results != null) {
      _dataList.add(result.results);
    }
    return result;
  }
}
