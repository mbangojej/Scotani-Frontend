import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';

import '../AppUtils.dart';

class DiscoverDesignContainer extends StatefulWidget {
  String image;
  String heading;
  String subHeading;
  String price;
  Function() onTap;

  DiscoverDesignContainer(
      {required this.image,
      required this.heading,
      required this.price,
      required this.subHeading,
      required this.onTap});

  @override
  State<DiscoverDesignContainer> createState() => _DiscoverDesignContainer();
}

class _DiscoverDesignContainer extends State<DiscoverDesignContainer> {
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
              width: static.width * .36,
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
                ))
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          width: static.width * .36,
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
              ),
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.r),
                        color: theme.orangeColor),
                    width: static.width * 0.18,
                    height: 25.h,
                    child: ElevatedButton(
                      onPressed: widget.onTap,
                      child: Text(
                        "Buy",
                        style: utils.labelStyle(theme.whiteColor,
                          fontFamily: 'finalBold',
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.orangeColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
