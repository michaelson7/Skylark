import 'package:flutter/material.dart';

import '../constants/constants.dart';

AppBar customeAppBar({required title}) {
  return AppBar(
    backgroundColor: kAccent,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 20,
      ),
    ),
  );
}
