import 'package:fast8_test/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildCategoryItem(String title, String image) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(
        'assets/images/$image.svg',
        width: 40,
        height: 40,
      ),
      buildVerticalSpacer(2),
      Text(title, textAlign: TextAlign.center),
    ],
  );
}
