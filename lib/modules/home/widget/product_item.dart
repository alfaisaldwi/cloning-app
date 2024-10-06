import 'package:fast8_test/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildProductItem(String title, String image, {bool isNew = false}) {
  return IntrinsicHeight(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/$image.svg',
          width: 40,
          height: 40,
        ),
        if (isNew)
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              'NEW',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        buildVerticalSpacer(2),
        Text(title, textAlign: TextAlign.center),
      ],
    ),
  );
}
