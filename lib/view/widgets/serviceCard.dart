import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

Widget serviceCard({
  required title,
  required imagePath,
  required Function function,
}) {
  return InkWell(
    onTap: () {
      function();
    },
    child: Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: kBorderRadiusCircular,
        image: DecorationImage(
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.8), BlendMode.dstATop),
          image: CachedNetworkImageProvider(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Text(title),
          ],
        ),
      ),
    ),
  );
}
