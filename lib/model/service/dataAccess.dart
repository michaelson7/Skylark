import 'dart:convert';

import 'package:skylark/model/service/networkHelper.dart';

dynamic getResponse(Uri uri) async {
  NetworkHelper networkHelper = NetworkHelper(uriPath: uri);
  try {
    final response = await networkHelper.getResponse();
    return response;
  } catch (e) {
    throw Exception('Error while parsing getResponse: $e');
  }
}

dynamic postResponse(Uri uri, dynamic body) async {
  NetworkHelper networkHelper = NetworkHelper(uriPath: uri, requestBody: body);
  try {
    final response = await networkHelper.postResponse();
    return response;
  } catch (e) {
    throw Exception('Error while parsing postResponse: $e');
  }
}
