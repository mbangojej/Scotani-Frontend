import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/ColoredSleekBar.dart';
import 'package:skincanvas/AppUtils/Widgets/ImageSizedSleekBar.dart';
import 'package:skincanvas/AppUtils/Widgets/WidgetUpAnimation.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:skincanvas/main.dart';
import 'dart:math' as math;

class EditTattooAndProductHelper {
  BuildContext context;
  ScreenshotController screenshotController;

  EditTattooAndProductHelper(this.context, this.screenshotController);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  List<String> imagesPath = [
    'assets/Images/BodyPartsImages/leftArm.png',
    'assets/Images/BodyPartsImages/rightArm.png',
    'assets/Images/BodyPartsImages/chest.png',
    'assets/Images/BodyPartsImages/neck.png',
    'assets/Images/BodyPartsImages/back.png',
    'assets/Images/BodyPartsImages/leftLeg.png',
    'assets/Images/BodyPartsImages/rightLeg.png',
    'assets/Images/BodyPartsImages/wrist.png',
  ];

  List<String> fontFamily = [
    'AmazedEmerald',
    'AnasthasyaSignature',
    'AnatasMadang',
    'AnetasMangan',
    'AnotherBrother',
    'BloomingFlowers',
    'ChewyPudding',
    'CreamyPeach',
    'CuteBirds',
    'DifferentSunset',
    'EveryTuesday',
    'FloralBotanical',
    'FlyingBirds',
    'FreshBeverage',
    'GeometricSpaceship',
    'GoesPagi',
    'GreatRechords',
    'HelloAdventure',
    'HElloBrader',
    'HelloLemonade',
    'HelloMiddlenight',
    'HelloMonday',
    'HelloRainbow',
    'HelloWednesday',
    'JumpsHigher',
    'KoweGalhak',
    'LaziestCat',
    'CakeLove',
    'LoveCoffee',
    'MadeMagicrex',
    'MeAndCoffee',
    'MoletRaenak',
    'MoonsLaughs',
    'MorningSinging',
    'PeachMezmerize',
    'PelemAnteman',
    'PelemAntemanRounded',
    'PiePineapple',
    'RainbowCake',
    'RooftopBotanical',
    'SpookyOkey',
    'SpringkledBotanical',
    'SummerHolidays',
    'SunriseMorning',
    'SunriseMorning1',
    'TheLastMidnight',
    'WednesdayAdventure',
    'WorstLaziest',
    'YummyPeach',
  ];

  Widget topBar() {
    return Container(
      padding: EdgeInsets.only(top: 10.h, bottom: 5.h, right: 20.w),
      width: static.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                homeRead.updateIsIncreaseTextSize(value: false);
                homeWatch.imagePreview
                    ? homeRead.updateImagePreview()
                    : Navigator.pop(context);
                // homeRead.updateIsShowGraphicsContainer(isBackButton: true);
              },
              icon: Icon(
                Icons.close,
                color: theme.whiteColor,
              )),
          homeWatch.imagePreview
              ? SizedBox()
              : Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        homeRead.updateTattooRotate();
                      },
                      child: Image.asset(
                        'assets/Icons/rotate.png',
                        height: static.width > 550 ? 20.h : 25.h,
                        width: static.width > 550 ? 20.w : 25.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
          homeWatch.imagePreview
              ? SizedBox()
              : SizedBox(
                  width: 15.w,
                ),
          homeWatch.imagePreview
              ? SizedBox()
              : GestureDetector(
                  onTap: () async {
                    generalRead.updateRestrictUserNavigation(value: true);

                    EasyLoading.show(status: "Setting Preview");
                    await screenshotController
                        .capture()
                        .then((capturedImage) async {
                      await homeRead.tattooShowForSSUpdate(value: false);
                      await homeWatch.updateCapturedImage(context,
                          image: capturedImage);
                    }).catchError((onError) {
                      print(onError);
                    });
                    print('Actual Call');
                    await screenshotController
                        .capture()
                        .then((capturedImage) async {
                      await homeWatch.updateCapturedImage(context,
                          image: capturedImage);
                    }).catchError((onError) {
                      print(onError);
                    });

                    if (homeWatch.finalActualImage.isNotEmpty &&
                        homeWatch.finalSampleImage.isNotEmpty) {
                      // homeWatch.updateImagePreview();
                      await homeRead.edgesCuttingApi(context,
                          previewImage: '${homeWatch.finalSampleImage}',
                          referenceImage: "${homeWatch.finalActualImage}");

                      generalRead.updateRestrictUserNavigation();
                    }
                  },
                  child: Text(
                    'Preview',
                    style: utils.generalHeadingBold(theme.orangeColor,
                        size: static.width > 550 ? 9.sp : 13.sp,
                        fontFamily: 'finalBold'),
                  ),
                ),
        ],
      ),
    );
  }

  Widget imageView() {
    return Consumer<HomeController>(builder: (context, homeWatch, _) {
      return Stack(
        children: [
          homeWatch.isFromTattoo
              ? SizedBox()
              : homeWatch.imagePreview
                  ? SizedBox()
                  : Container(
                      height: static.height * .59,
                      width: static.width,
                      color: theme.backGroundColor,
                    ),
          homeWatch.imagePreview
              ? Container(
                  height: static.height * .50,
                  width: static.width,
                  decoration: BoxDecoration(color: theme.backGroundColor),
                )
              : AnimatedContainer(
                  duration: Duration(milliseconds: 700),
                  height: homeWatch.isSwipeClick
                      ? static.height * .70
                      : homeWatch.isFromTattoo
                          ? static.height * .60
                          : static.height * .53,
                  width: static.width,
                  decoration: BoxDecoration(
                    color: theme.lightBlackColor,
                  ),
                ),
          Positioned(
            top: (static.height * 0.60 - static.height * 0.52) / 2,
            left: (static.width - static.width * 0.80) / 2,
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width * 0.80,
                child: homeWatch.imagePreview
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.80,
                        decoration: BoxDecoration(
                          color: theme.lightBlackColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.memory(
                          homeWatch.previewFinalImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.45,
                            width: MediaQuery.of(context).size.width * 0.80,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Center(
                            child: homeWatch.isFromTattoo
                                ? Transform.scale(
                                    scale: 1.1,
                                    child: Image.asset(
                                      imagesPath[homeWatch.bodyPartIndexUpdate],
                                      height: static.height * .37,
                                      width: static.width * .65,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : Transform.scale(
                                    scale: 1.3,
                                    child: Image.network(
                                      homeWatch.selectedProduct!.attributes!
                                              .first.color!.isNotEmpty
                                          ? homeWatch
                                              .selectedProduct!
                                              .attributes!
                                              .first
                                              .color![homeWatch
                                                  .selectedProductColorImageIndex]
                                              .image
                                              .toString()
                                          : '${homeWatch.selectedProduct!.image}',
                                      height: static.height * .37,
                                      width: static.width * .65,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                          ),
                          if (!homeWatch.isTattooShowForSS) ...[
                            for (int i = 0;
                                i <
                                    homeWatch
                                        .selectableTattoosAndGraphicList.length;
                                i++) ...[
                              Positioned(
                                left: homeWatch.mdSizeGroup.mdSizeGroupData !=
                                        null
                                    ? (homeWatch.imageSizeList[i] ==
                                                homeWatch
                                                    .mdSizeGroup
                                                    .mdSizeGroupData!
                                                    .sizeLimits!
                                                    .end!
                                                    .toDouble() &&
                                            homeWatch
                                                    .mdSizeGroup
                                                    .mdSizeGroupData!
                                                    .sizeLimits!
                                                    .end!
                                                    .toDouble() >
                                                45.0
                                        ? homeWatch.imageOffSetList[i].dx - 60.0
                                        : homeWatch.imageOffSetList[i].dx)
                                    : homeWatch.imageOffSetList[i].dx,
                                top: homeWatch.mdSizeGroup.mdSizeGroupData !=
                                        null
                                    ? (homeWatch.imageSizeList[i] ==
                                                homeWatch
                                                    .mdSizeGroup
                                                    .mdSizeGroupData!
                                                    .sizeLimits!
                                                    .end!
                                                    .toDouble() &&
                                            homeWatch
                                                    .mdSizeGroup
                                                    .mdSizeGroupData!
                                                    .sizeLimits!
                                                    .end!
                                                    .toDouble() >
                                                45.0
                                        ? homeWatch.imageOffSetList[i].dy - 60.0
                                        : homeWatch.imageOffSetList[i].dy)
                                    : homeWatch.imageOffSetList[i].dy,
                                child: GestureDetector(
                                  onTap: () async {
                                    await homeRead.selectableImageStatusUpdate(
                                        index: i);
                                    await homeRead.isImageOrTextUpdation(
                                        value: true);
                                  },
                                  onPanUpdate: (details) {
                                    final parentSize = Size(
                                      MediaQuery.of(context).size.width * 0.80,
                                      MediaQuery.of(context).size.height * 0.45,
                                    );

                                    var selectedOffSet = Offset(
                                      (homeWatch.imageOffSetList[i].dx +
                                              details.delta.dx)
                                          .clamp(
                                        0.0,
                                        parentSize.width -
                                            homeWatch.imageSizeList[i] / 2,
                                      ),
                                      (homeWatch.imageOffSetList[i].dy +
                                              details.delta.dy)
                                          .clamp(
                                        0.0,
                                        parentSize.height -
                                            homeWatch.imageSizeList[i] / 2,
                                      ),
                                    );
                                    List<Offset> offSetList = [];

                                    for (int j = 0;
                                        j <
                                            homeWatch
                                                .selectableTattoosAndGraphicList
                                                .length;
                                        j++) {
                                      if (j == i) {
                                        offSetList.add(selectedOffSet);
                                      } else {
                                        offSetList
                                            .add(homeWatch.imageOffSetList[j]);
                                      }
                                    }

                                    homeRead.updateOffset(
                                        imageOffsetValue: offSetList,
                                        textOffsetValue: homeWatch.textOffset);

                                    // Calculate the rotation angle in radians
                                    homeRead.updateCurrentRotation(
                                        value: details.delta.dy,
                                        isImage: !homeWatch.isIncreaseTextSize);

                                    // If rotating is active, update the rotation angle
                                    if (homeWatch.isImageRotating) {
                                      homeRead.updateRotationTattooAngle(
                                          tattoo: homeWatch
                                                  .tattooRotationalAngleList[
                                              i] += details.delta.dy,
                                          text: homeWatch.rotationAngleForText);
                                    }
                                  },
                                  onDoubleTap: () {
                                    // Toggle the rotating flag on double tap
                                    homeRead.updateIsRotating(
                                        value: !homeWatch.isImageRotating,
                                        isImage: !homeWatch.isIncreaseTextSize);
                                  },
                                  child: Transform.rotate(
                                      angle: homeWatch
                                              .tattooRotationalAngleList[i] *
                                          (math.pi / 180),
                                      child:
                                          // !homeWatch.isFromTattoo
                                          //     ? Image.asset(
                                          //         'assets/Images/shirtLogo.png',
                                          //         height: homeWatch.imageSizeList[i],
                                          //         width: homeWatch.imageSizeList[i],
                                          //         color: homeWatch.imageColorList[i],
                                          //         fit: BoxFit.contain,
                                          //       )
                                          //     :

                                          homeWatch.selectableImageIndex == i &&
                                                  homeWatch
                                                          .isIncreaseTextSize ==
                                                      false &&
                                                  generalRead
                                                          .restrictUserNavigation ==
                                                      false
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: theme
                                                              .lightGreyColor)),
                                                  child: Image.network(
                                                    '${homeWatch.selectableTattoosAndGraphicList[i]}',
                                                    height: homeWatch
                                                        .imageSizeList[i],
                                                    width: homeWatch
                                                        .imageSizeList[i],
                                                    color: null,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              : Image.network(
                                                  '${homeWatch.selectableTattoosAndGraphicList[i]}',
                                                  height: homeWatch
                                                      .imageSizeList[i],
                                                  width: homeWatch
                                                      .imageSizeList[i],
                                                  color: null,
                                                  fit: BoxFit.contain,
                                                )

                                      //     Image.memory(
                                      //   homeWatch.selectableTattoosAndGraphicList[i],
                                      //   height: homeWatch.imageSizeList[i],
                                      //   width: homeWatch.imageSizeList[i],
                                      //   color:
                                      //   // homeWatch.isIncreaseTextSize &&
                                      //   //     homeWatch.imageColorList[i] !=
                                      //   //         Color(0xffFFFFFF)
                                      //   //     ? homeWatch.imageColorList[i]
                                      //   //     :
                                      //   null,
                                      //   fit: BoxFit.contain,
                                      // )

                                      ),
                                ),
                              ),
                            ],
                            Positioned(
                              left: homeWatch.mdSizeGroupText.mdSizeGroupData !=
                                      null
                                  ? (homeWatch.textSize ==
                                          homeWatch
                                              .mdSizeGroupText
                                              .mdSizeGroupData!
                                              .sizeLimits!
                                              .start!
                                              .toDouble()
                                      ? homeWatch.textOffset.dx - 20.0
                                      : homeWatch.textOffset.dx)
                                  : homeWatch.textOffset.dx,
                              top: homeWatch.mdSizeGroupText.mdSizeGroupData !=
                                      null
                                  ? (homeWatch.textSize ==
                                          homeWatch
                                              .mdSizeGroupText
                                              .mdSizeGroupData!
                                              .sizeLimits!
                                              .start!
                                              .toDouble()
                                      ? homeWatch.textOffset.dy - 10.0
                                      : homeWatch.textOffset.dy)
                                  : homeWatch.textOffset.dy,
                              child: GestureDetector(
                                onTap: () {
                                  homeWatch.isFromTattoo
                                      ? homeRead.isImageOrTextUpdation(
                                          value: false)
                                      : null;
                                },
                                onPanUpdate: (details) {
                                  final parentSize = Size(
                                    MediaQuery.of(context).size.width * 0.80,
                                    MediaQuery.of(context).size.height * 0.45,
                                  );

                                  homeRead.updateOffset(
                                      textOffsetValue: Offset(
                                        (homeWatch.textOffset.dx +
                                                details.delta.dx)
                                            .clamp(
                                          0.0,
                                          parentSize.width - homeWatch.textSize,
                                        ),
                                        (homeWatch.textOffset.dy +
                                                details.delta.dy)
                                            .clamp(
                                          0.0,
                                          parentSize.height -
                                              homeWatch.textSize,
                                        ),
                                      ),
                                      imageOffsetValue:
                                          homeWatch.imageOffSetList);

                                  // Calculate the rotation angle in radians
                                  homeRead.updateCurrentRotation(
                                      value: details.delta.dy,
                                      isImage: !homeWatch.isIncreaseTextSize);

                                  // If rotating is active, update the rotation angle
                                  if (homeWatch.isImageRotating) {
                                    homeRead.updateRotationTattooAngle(
                                        text: homeWatch.rotationAngleForText +=
                                            details.delta.dy,
                                        tattoo: homeWatch
                                            .tattooRotationalAngleList);
                                  }
                                },
                                onDoubleTap: () {
                                  // Toggle the rotating flag on double tap
                                  homeRead.updateIsRotating(
                                    value: !homeWatch.isImageRotating,
                                    isImage: !homeWatch.isIncreaseTextSize,
                                  );
                                },
                                child: Transform.rotate(
                                  angle: homeWatch.rotationAngleForText *
                                      (math.pi / 180),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 5.h),
                                    child: Text(
                                      !homeWatch.isFromTattoo
                                          ? '${homeWatch.productDesireTextController.text}'
                                          : '${homeWatch.desireTextController.text}',
                                      style: utils.generalHeading(
                                          homeWatch.textColor,
                                          size: homeWatch.textSize,
                                          fontFamily: fontFamily[homeWatch
                                              .selectedFontFamilyIndex]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
              ),
            ),
          ),
          homeWatch.imagePreview
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              : SizedBox(),
          homeWatch.isFromTattoo
              ? Positioned(
                  bottom: 0.h,
                  left: 0.w,
                  right: 0.w,
                  child: homeWatch.isSwipeClick || homeWatch.imagePreview
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () {
                            homeRead.updateSwipeClick();
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15.h),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  color: theme.midGreyColor,
                                  size: 35.w,
                                ),
                                Text(
                                  'Swipe up for body parts',
                                  style: utils.labelStyle(theme.midGreyColor),
                                )
                              ],
                            ),
                          ),
                        ),
                )
              : SizedBox(),
          homeWatch.isFromTattoo
              ? SizedBox()
              : homeWatch.imagePreview
                  ? SizedBox()
                  : homeWatch.productDesireTextController.text.isNotEmpty
                      ? Positioned(
                          bottom: 0.h,
                          right: 30.w,
                          child: textIcon(),
                        )
                      : SizedBox(),
        ],
      );
    });
  }

  Widget setColorAndSize() {
    return homeWatch.imagePreview
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Congratulations',
                    style: utils.generalHeading(theme.orangeColor,
                        size: static.width > 550 ? 22.sp : 28.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'It looks perfect!',
                    style: utils.generalHeading(theme.whiteColor,
                        size: static.width > 550 ? 18.sp : 24.sp),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: placeOrderButton(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : homeWatch.isSwipeClick
            ? selectBodyArea()
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 37.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homeWatch.isFromTattoo
                        ? SizedBox()
                        : Text(
                            homeWatch.isIncreaseTextSize
                                ? 'Text Settings'
                                : 'Graphics Settings',
                            style: utils.xlHeadingStyle(theme.whiteColor,
                                fontFamily: 'finalBold'),
                          ),
                    homeWatch.isFromTattoo
                        ? SizedBox()
                        : SizedBox(
                            height: 15.h,
                          ),
                    // homeWatch.createTattooDesignSelection[0]
                    homeWatch.isIncreaseTextSize
                        ? Text(
                            homeWatch.isFromTattoo
                                ? 'Color'
                                : homeWatch.isIncreaseTextSize
                                    ? 'Text Color'
                                    : 'Graphics Color',
                            style: utils.labelStyle(theme.whiteColor,
                                fontFamily: 'finalBold'),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 5.h,
                    ),
                    // homeWatch.createTattooDesignSelection[0]
                    homeWatch.isIncreaseTextSize
                        ? Text(
                            homeWatch.isFromTattoo
                                ? homeWatch.isImage
                                    ? 'Change your tattoo color'
                                    : 'Change your text color'
                                : homeWatch.isIncreaseTextSize
                                    ? 'Change your text color'
                                    : 'Change your graphics color',
                            style: utils.labelStyle(theme.midGreyColor,
                                fontFamily: 'finalBold'),
                          )
                        : SizedBox(),

                    homeWatch.isIncreaseTextSize
                        ? SizedBox(
                            height: 10.h,
                          )
                        : SizedBox(),

                    // homeWatch.createTattooDesignSelection[0]
                    homeWatch.isIncreaseTextSize
                        ? Text(
                            'Hue',
                            style: utils.labelStyle(theme.whiteColor,
                                fontFamily: 'finalBold'),
                          )
                        : SizedBox(),
                    homeWatch.isIncreaseTextSize
                        ? TextColorPicker(width: static.width * .68)
                        : SizedBox(),
                    // homeWatch.createTattooDesignSelection[0]
                    // homeWatch.isIncreaseTextSize
                    //         ? ImageColorPicker(width: static.width * .68)
                    //         : Container(),
                    homeWatch.isIncreaseTextSize
                        ? SizedBox(
                            height: 10.h,
                          )
                        : SizedBox(),
                    Text(
                      /* homeWatch.isFromTattoo
                          ? 'Scale Size'
                          :*/
                      homeWatch.isIncreaseTextSize
                          ? 'Font Size'
                          : 'Graphics Size',
                      style: utils.labelStyle(theme.whiteColor,
                          fontFamily: 'finalBold'),
                    ),
                    ImageSleekBar(),
                    homeWatch.isIncreaseTextSize
                        ? SizedBox(
                            height: 10.h,
                          )
                        : SizedBox(),
                    homeWatch.isIncreaseTextSize
                        ? Text(
                            'Font Family',
                            style: utils.labelStyle(theme.whiteColor,
                                fontFamily: 'finalBold'),
                          )
                        : SizedBox(),
                    homeWatch.isIncreaseTextSize
                        ? fontFamilySelection()
                        : SizedBox(),
                  ],
                ),
              );
  }

  Widget textIcon() {
    return GestureDetector(
      onTap: () {
        homeRead.isImageOrTextUpdation(value: homeWatch.isImage ? false : true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: theme.lightBlackColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(4.r),
            bottomRight: Radius.circular(4.r),
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/Images/textIcon.png',
            height: static.width > 550 ? 25.h : 30.h,
            width: static.width > 550 ? 25.w : 30.w,
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }

  Widget fontFamilySelection() {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            for (int i = 0; i < fontFamily.length; i++)
              utils.fontFamilySelectionContainer(
                height: static.width * .19,
                width: static.width * .19,
                text: 'ABC',
                textSize: 18.0.sp,
                fontFamily: fontFamily[i],
                index: i,
                selectedIndex: homeWatch.selectedFontFamilyIndex,
                onTap: () async {
                  homeRead.updateSelectedFontFamilyIndex(index: i);
                },
              ),
          ],
        ));
  }

  Widget selectBodyArea() {
    return WidgetUpAnimation(
      top_to_bottom: false,
      height: 100.0,
      // The distance the widget will move during animation
      duration: Duration(milliseconds: 700),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  onPressed: () {
                    homeRead.updateSwipeClick();
                  },
                  icon: Icon(
                    Icons.close,
                    color: theme.whiteColor,
                  )),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'L-Arm',
                      image: 'assets/Images/BodyParts/l-arm.png',
                      imageSize: homeWatch.createTattooBodySelection[0]
                          ? static.width * .09
                          : static.width * .08,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[0],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 0);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'R-Arm',
                      image: 'assets/Images/BodyParts/r-arm.png',
                      imageSize: homeWatch.createTattooBodySelection[1]
                          ? static.width * .10
                          : static.width * .09,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[1],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 1);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'Chest',
                      image: 'assets/Images/BodyParts/chest.png',
                      imageSize: homeWatch.createTattooBodySelection[2]
                          ? static.width * .11
                          : static.width * .1,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[2],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 2);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'Neck',
                      image: 'assets/Images/BodyParts/neck.png',
                      imageSize: homeWatch.createTattooBodySelection[3]
                          ? static.width * .17
                          : static.width * .15,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[3],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 3);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'Back',
                      image: 'assets/Images/BodyParts/back.png',
                      imageSize: homeWatch.createTattooBodySelection[4]
                          ? static.width * .11
                          : static.width * .1,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[4],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 4);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'L-Leg',
                      image: 'assets/Images/BodyParts/l-leg.png',
                      imageSize: homeWatch.createTattooBodySelection[5]
                          ? static.width * .065
                          : static.width * .055,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[5],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 5);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'R-Leg',
                      image: 'assets/Images/BodyParts/r-leg.png',
                      imageSize: homeWatch.createTattooBodySelection[6]
                          ? static.width * .065
                          : static.width * .055,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[6],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 6);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                    utils.categorySelectionContainer(
                      isNetwork: false,
                      height: static.width * .19,
                      width: static.width * .19,
                      text: 'Wrist',
                      image: 'assets/Images/BodyParts/wrist.png',
                      imageSize: homeWatch.createTattooBodySelection[7]
                          ? static.width * .095
                          : static.width * .08,
                      textSize: 12.0.sp,
                      isSelect: homeWatch.createTattooBodySelection[7],
                      onTap: () async {
                        homeRead.createTattooBodySelectionUpdate(index: 7);
                        await homeRead.sizeGroupAPi(context);
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget placeOrderButton() {
    return Container(
      width: static.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      child: utils.button(
        textSize: static.width > 550 ? 10.sp : 20.sp,
        text: 'Place Your Order',
        buttonColor: theme.orangeColor,
        borderColor: theme.orangeColor,
        fontFamily: 'finalBold',
        ontap: () async {
          await orderRead.placeOrderBodySelectionInitialize();
          await homeRead.calculateSizeGroupPriceFunc();
          await orderRead.placeOrderSelectedImageUpdate(index: 0);

          if (!homeWatch.isFromTattoo) {
            homeRead.variationGroupApi(context);
          } else {
            Navigator.pushNamed(context, route.placeOrderScreenRoute);
          }
        },
        textColor: theme.whiteColor,
        width: static.width,
      ),
    );
  }
}
