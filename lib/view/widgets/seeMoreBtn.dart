import 'package:flutter/material.dart';

import '../constants/constants.dart';

InkWell seeMoreBtn({
  required text,
  required Function function,
}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: kTextStyleAccent),
    ),
  );
}
