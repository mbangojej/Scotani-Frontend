import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';

import '../AppUtils.dart';

class FeaturedContainer extends StatefulWidget {
  String image;
  String heading;
  String subHeading;
  String price;

  FeaturedContainer(
      {required this.image,
      required this.heading,
      required this.price,
      required this.subHeading});

  @override
  State<FeaturedContainer> createState() => _FeaturedContainer();
}

class _FeaturedContainer extends State<FeaturedContainer> {
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: static.width * .8,
              height: static.width * .38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Image.network(
                '${widget.image}',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                right: 8.w,
                bottom: 8.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/Icons/priceTag.png',
                      width: 56.w,
                    ),
                    Text(
                      '${widget.price}',
                      textAlign: TextAlign.center,
                      style: utils.smallLabelStyleB(theme.orangeColor,
                          fontFamily: 'finalBold'),
                    )
                  ],
                )),
            Positioned(
              right: 8.w,
              top: 10.h,
              child: Image.asset(
                'assets/Icons/featured.png',
                width: 32.w,
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          width: static.width * .8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Text(
                '${widget.heading}',
                style: utils.labelStyleB(theme.whiteColor,
                    fontFamily: 'finalBold'),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                '${widget.subHeading}',
                style: utils.smallLabelStyleB(theme.midGreyColor,
                    fontFamily: 'finalBold'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
