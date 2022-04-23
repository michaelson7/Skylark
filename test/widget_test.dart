// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skylark/main.dart';
import 'package:skylark/model/core/UsersModel.dart';
import 'package:skylark/provider/BookingProvider.dart';
import 'package:skylark/provider/UsersProvider.dart';

void main() {
  test("bookingGetAll", () async {
    var provider = BookingProvider();
    var result = await provider.bookingsGetAll(showResponse: true);
  });

  test("loginUser", () async {
    var provider = UsersProvider();
    var result = await provider.usersLogin(
      showResponse: true,
      model: UsersModel(
        id: 0,
        names: "names",
        email: "email",
        password: "password",
        accountTypeId: 0,
      ),
    );
  });
}
