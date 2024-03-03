import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/main.dart';
import 'package:flutter/rendering.dart';

class CustomSliderTrackShape extends RoundedRectSliderTrackShape {
  final double borderRadius;

  CustomSliderTrackShape({this.borderRadius = 8.0});

  @override
  Rect getPreferredRect({
    RenderBox? parentBox,
    Offset offset = Offset.zero,
    SliderThemeData? sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme!.trackHeight;

    final trackLeft = offset.dx + borderRadius;
    final trackTop = offset.dy + (parentBox!.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width - 2 * borderRadius;

    final activeTrackRect =
        Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);

    return isDiscrete ? activeTrackRect : activeTrackRect;
  }
}

class ImageSleekBar extends StatefulWidget {
  @override
  _ImageSleekBarState createState() => _ImageSleekBarState();
}

class _ImageSleekBarState extends State<ImageSleekBar> {
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0,
              trackShape: CustomSliderTrackShape(borderRadius: 8.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Slider(
                  activeColor: Colors.grey.withOpacity(.7),
                  inactiveColor: Colors.grey.withOpacity(.7),
                  thumbColor: Colors.white,
                  value: homeWatch.isIncreaseTextSize
                      ? homeWatch.textSize
                      : homeWatch.imageSizeList[homeWatch.selectableImageIndex],
                  min: homeWatch.isIncreaseTextSize
                      ? homeWatch
                          .mdSizeGroupText.mdSizeGroupData!.sizeLimits!.start!
                          .toDouble()
                      :
                      // homeWatch.isFromTattoo
                      //         ?
                      homeWatch.mdSizeGroup.mdSizeGroupData!.sizeLimits!.start!
                          .toDouble(),
                  // : 30.0,
                  max: homeWatch.isIncreaseTextSize
                      ? homeWatch
                          .mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end!
                          .toDouble()
                      :
                      // homeWatch.isFromTattoo
                      //         ?
                      homeWatch.mdSizeGroup.mdSizeGroupData!.sizeLimits!.end!
                          .toDouble(),
                  // : 250.0,
                  onChanged: (value) {
                    if (homeWatch.isIncreaseTextSize) {
                      homeRead.updateTextSize(size: value);
                    } else {
                      homeRead.updateImageSize(
                          size: value, index: homeWatch.selectableImageIndex);
                    }
                  },
                ),
                Align(
                  alignment: homeWatch.isIncreaseTextSize
                      ? Alignment(
                          (homeWatch.textSize - (homeWatch.mdSizeGroupText.mdSizeGroupData!.sizeLimits!.start!.toDouble())) /
                                  ((homeWatch.mdSizeGroupText.mdSizeGroupData!.sizeLimits!.end!.toDouble()) -
                                      (homeWatch.mdSizeGroupText
                                          .mdSizeGroupData!.sizeLimits!.start!
                                          .toDouble())) *
                                  2 -
                              1,
                          1.0)
                      : Alignment(
                          (homeWatch.imageSizeList[homeWatch.selectableImageIndex] -
                                      (homeWatch.mdSizeGroup.mdSizeGroupData!
                                          .sizeLimits!.start!
                                          .toDouble())) /
                                  ((homeWatch.mdSizeGroup.mdSizeGroupData!.sizeLimits!.end!.toDouble()) -
                                      (homeWatch.mdSizeGroup.mdSizeGroupData!
                                          .sizeLimits!.start!
                                          .toDouble())) *
                                  2 -
                              1,
                          1.0),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 60.h),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      '${homeWatch.isIncreaseTextSize ? (homeWatch.textSize / 8).floor() : (homeWatch.imageSizeList[homeWatch.selectableImageIndex] / 8).floor()}',
                      style: utils.smallLabelStyleB(theme.blackColor),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.h),
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (homeWatch.isIncreaseTextSize
                                ? homeWatch.mdSizeGroupText.mdSizeGroupData!
                                        .sizeLimits!.start! /
                                    8
                                : homeWatch.mdSizeGroup.mdSizeGroupData!
                                        .sizeLimits!.start! /
                                    8)
                            .toString(),
                        style: utils.smallLabelStyle(theme.whiteColor),
                      ),
                      Text(
                        (homeWatch.isIncreaseTextSize
                                ? homeWatch.mdSizeGroupText.mdSizeGroupData!
                                        .sizeLimits!.end! /
                                    8
                                : homeWatch.mdSizeGroup.mdSizeGroupData!
                                        .sizeLimits!.end! /
                                    8)
                            .toString(),
                        style: utils.smallLabelStyle(theme.whiteColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // : SizedBox(),
      ],
    );
  }
}
