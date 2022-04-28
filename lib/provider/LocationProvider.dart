import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:skylark/model/core/LocationModel.dart';

import '../model/service/ApiHelper.dart';

class LocationProvider extends ChangeNotifier {
  final _apiHelper = ApiHelper();
  final _dataList = BehaviorSubject<List<LocationModelObj>?>();

  get providerList => _dataList.stream;

  Future<LocationModel> locationGetAll({bool showResponse = false}) async {
    var result = await _apiHelper.locationGetAll(
      showResponse: showResponse,
    );
    if (result.results != null) {
      _dataList.add(result.results);
    }
    return result;
  }
}
