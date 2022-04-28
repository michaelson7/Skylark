import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skylark/provider/SharedPreferenceProvider.dart';

import '../constants/constants.dart';
import '../views/activities/setup/login.dart';

AppBar customeAppBar({required title, required context}) {
  return AppBar(
    backgroundColor: kAccent,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
      ),
    ),
    actions: [
      InkWell(
        onTap: () {
          SharedPreferenceProvider sp = SharedPreferenceProvider();
          sp.logOut();
          Navigator.popAndPushNamed(context, LoginActivity.id);
        },
        child: Icon(FontAwesome5.window_close),
      ),
    ],
  );
}
