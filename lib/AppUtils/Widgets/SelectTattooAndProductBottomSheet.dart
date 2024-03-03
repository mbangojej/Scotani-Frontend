import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Models/MDTattooGenerationModal.dart';

class SelectTattooAndProductBottomSheet {
  var static = Statics();
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var route = Routes();

  SelectTattooAndProductBottomSheet();

  sheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: themeColor.transparentColor,
      isScrollControlled: true,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Consumer<HomeController>(
              builder: (context, homeRead, _) {
                return BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    child: Container(
                      height: static.width > 500
                          ? static.height * 0.8
                          : static.height * 0.7,
                      width: static.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16.0.r),
                            topLeft: Radius.circular(16.0.r)),
                        color: themeColor.whiteColor,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0.h) +
                            EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    'assets/Icons/xMark.png',
                                    height: static.width > 550 ? 14.h : 18.h,
                                    width: static.width > 550 ? 14.w : 18.w,
                                    color: themeColor.greyColor,
                                  )),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text('Please Choose',
                                style: utils.generalHeadingBold(
                                    themeColor.blackColor,
                                    fontFamily: "finalBold",
                                    size: static.width > 550 ? 16.sp : 24.sp),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    chooseFunction(context,
                                        color: homeRead.isTattooSelect,
                                        onTap: () {
                                      homeRead.categorySelectionToCreate(
                                        product: false,
                                        tattoo: true,
                                      );
                                    },
                                        image: 'selectTattoo',
                                        text: 'Create Tattoo'),
                                    chooseFunction(context,
                                        color: homeRead.isProductSelect,
                                        onTap: () {
                                      homeRead.categorySelectionToCreate(
                                        product: true,
                                        tattoo: false,
                                      );
                                    },
                                        text: 'Create Product',
                                        image: 'selectProduct'),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    homeRead.isProductSelect == false &&
                                            homeRead.isTattooSelect == false
                                        ? SizedBox()
                                        : Container(
                                            width: static.width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 18.h,
                                                horizontal: static.width > 500
                                                    ? 15.w
                                                    : 0.w),
                                            child: utils.button(
                                              textSize: static.width > 550
                                                  ? 10.sp
                                                  : 20.sp,
                                              text: "Let's Start",
                                              buttonColor:
                                                  themeColor.orangeColor,
                                              borderColor:
                                                  themeColor.orangeColor,
                                              fontFamily: 'finalBold',
                                              ontap: () async {
                                                if (homeRead.isTattooSelect) {
                                                  homeRead
                                                      .designPromptController
                                                      .text = '';
                                                  homeRead.desireTextController
                                                      .text = '';
                                                  homeRead.desireColorController
                                                      .text = '';

                                                  await homeRead
                                                      .createTattooBodySelectionInitialize();
                                                  await homeRead
                                                      .createTattooDesignSelectionInitialize();
                                                  await homeRead
                                                      .selectGraphicsStatusInitialize();

                                                  await homeRead
                                                      .updateIsShowGraphicsContainer(
                                                          isBackButton: true);

                                                  Navigator.pop(context);

                                                  Navigator.pushNamed(
                                                      context,
                                                      route
                                                          .createTattooScreenRoute);

                                                  homeRead
                                                      .updateImageColorSliderPosition(
                                                          position: 0.0);

                                                  homeRead
                                                      .updateImageShadeSliderPosition(
                                                          position: 0.0);

                                                  // homeRead
                                                  //     .updateImageCurrentColor(
                                                  //         color: themeColor
                                                  //             .whiteColor);

                                                  await  homeRead.updateBaseColorIniatlize(
                                                      Color(0xffffffff));

                                                  homeRead.updateImageSize(
                                                      size: 30.0);
                                                  homeRead.updateTextSize(
                                                      size: 10.0);

                                                } else if (homeRead
                                                    .isProductSelect) {
                                                  await homeRead
                                                      .categoryListingApi(
                                                    context,
                                                    type: '3',
                                                    title: '',
                                                    isLoading: false,
                                                  );

                                                  homeRead
                                                      .productDesirePromptController
                                                      .text = '';
                                                  homeRead
                                                      .productDesireTextController
                                                      .text = '';

                                                  await homeRead
                                                      .selectConfigurableCategoriesInitialize(
                                                          length: homeRead
                                                              .configureDataList
                                                              .length);

                                                  await homeRead
                                                      .createTattooDesignSelectionInitialize();
                                                  await homeRead
                                                      .selectGraphicsStatusInitialize();

                                                  await homeRead
                                                      .updateIsShowGraphicsContainer(
                                                          isBackButton: true);

                                                  Navigator.pop(context);

                                                  Navigator.pushNamed(
                                                      context,
                                                      route
                                                          .selectCategoryScreenRoute);

                                                  homeRead
                                                      .updateImageColorSliderPosition(
                                                          position: 0.0);

                                                  homeRead
                                                      .updateImageShadeSliderPosition(
                                                          position: 0.0);

                                                  // homeRead
                                                  //     .updateImageCurrentColor(
                                                  //         color: themeColor
                                                  //             .whiteColor);
                                                  await homeRead.updateBaseColorIniatlize(
                                                      Color(0xffffffff));

                                                  homeRead.updateImageSize(
                                                      size: 30.0);
                                                  homeRead.updateTextSize(
                                                      size: 10.0);

                                                }
                                              },
                                              textColor: themeColor.whiteColor,
                                              width: static.width,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  chooseFunction(BuildContext context, {color, onTap, image, text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        width: static.width > 550 ? static.width * .45 : static.width * .6,
        height: static.width > 550 ? static.width * .32 : static.width * .42,
        decoration: BoxDecoration(
            color: color ? themeColor.orangeColor : themeColor.blackColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12.0.r)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/JSON/$image.json',
                width: static.width > 550
                    ? static.width * .32
                    : static.width * .40,
                height: static.width > 550
                    ? static.width * .28
                    : static.width * .35,
              ),
              Center(
                  child: Text('$text',
                      style: utils.smallLabelStyleB(themeColor.whiteColor,
                          fontFamily: "finalBold"),
                      textAlign: TextAlign.center)),
            ],
          ),
        ),
      ),
    );
  }
}
