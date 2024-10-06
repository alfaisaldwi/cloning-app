import 'package:fast8_test/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

Widget buildWellnessItem(String title, String image, String price,
    {bool isDiscount = false, String? priceDiscount, String? percentDiscount}) {
  return IntrinsicHeight(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/$image.svg',
          width: 100,
          height: 60,
        ),
        buildVerticalSpacer(20),
        Text(title, textAlign: TextAlign.left),
        buildVerticalSpacer(8),
        if (isDiscount)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rp $price',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  buildHorizontalSpacer(6),
                  Text(
                    '$percentDiscount% OFF',
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Rp $price',
            textAlign: TextAlign.left,
          ),
        ),
      ],
    ),
  );
}
