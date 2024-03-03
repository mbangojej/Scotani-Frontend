import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/WidgetUpAnimation.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Views/FragmentScreens/BottomNavigationBar.dart';
import 'package:skincanvas/main.dart';

class CreateTattooHelper {
  BuildContext context;

  CreateTattooHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  var orderWatch =
      navigatorkey.currentContext!.watch<OrderCheckOutWishlistController>();
  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  Widget createYourTattooText() {
    return utils.appBar(context, barText: 'Create Your Tattoo', onPress: () {
      homeRead.updateIsShowGraphicsContainer(isBackButton: true);
      // Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigation(),
          ));
    });
  }

  Widget designPrompt() {
    return SizedBox(
      height: 177.h,
      child: Stack(
        children: [
          Container(
            height: 177.h,
            width: static.width,
            decoration: BoxDecoration(
              color: theme.lightBlackColor,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(top: 26.h),
              child: Image.asset(
                'assets/Images/triangle.png',
                height: static.width * .60,
                width: static.width * .60,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 22.w, right: 25.w),
                    child: utils.inputField(
                        textColor: theme.whiteColor,
                        placeholderColor: theme.midGreyColor,
                        placeholder: 'Design prompt',
                        controller: homeWatch.designPromptController,
                        isSecure: false,
                        //    controller: authWatch.loginEmailController,
                        maxLines: 1,
                        textfieldColor: theme.transparentColor,
                        borderColor: theme.whiteColor,
                        onChange: (value) {
                          if (value == '') {
                            homeRead.updateIsShowGraphicsContainer(
                                isBackButton: true);
                          }
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 22.w, right: 25.w),
                    child: utils.inputField(
                      textColor: theme.blackColor,
                      placeholderColor: theme.midGreyColor.withOpacity(.7),
                      placeholder: 'Desire Text',
                      controller: homeWatch.desireTextController,
                      isSecure: false,
                      // controller: authWatch.loginEmailController,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectBodyArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 12.w),
            child: Text(
              'Select Body Area',
              style: utils.xxlHeadingStyle(theme.whiteColor,
                  fontFamily: 'finalBold'),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Wrap(
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 0);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 1);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 2);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 3);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 4);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 5);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 6);
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
                onTap: () {
                  homeRead.createTattooBodySelectionUpdate(index: 7);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget selectDesignColor() {
    return homeWatch.isShowGraphicsContainer
        ? selectGraphic()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 12.w),
                  child: Text(
                    'Select Design Color',
                    style: utils.xxlHeadingStyle(theme.whiteColor,
                        fontFamily: 'finalBold'),
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      selectDesignContainer(
                        image: 'assets/Images/DesignColors/ellipse.png',
                        isSelect: homeWatch.createTattooDesignSelection[0],
                        text: 'Black & White',
                        imageSize: 50.w,
                        selectedImage:
                            'assets/Images/DesignColors/activeStateElipse.png',
                        height: static.width > 550
                            ? static.width * .22
                            : static.width * .26,
                        width: static.width > 550
                            ? static.width * .22
                            : static.width * .26,
                        onTap: () {
                          homeRead.createTattooDesignSelectionUpdate(index: 0);
                        },
                      ),
                      selectDesignContainer(
                        image: 'assets/Images/DesignColors/colorBox.png',
                        isSelect: homeWatch.createTattooDesignSelection[1],
                        text: 'Colored',
                        imageSize: homeWatch.createTattooDesignSelection[1]
                            ? static.width > 500
                                ? 150.0
                                : 65.0
                            : static.width > 500
                                ? 100.0
                                : 50.0,
                        selectedImage:
                            'assets/Images/DesignColors/aciveStateColorBox.png',
                        height: static.width > 550
                            ? static.width * .22
                            : static.width * .26,
                        width: static.width > 550
                            ? static.width * .22
                            : static.width * .26,
                        onTap: () {
                          homeRead.createTattooDesignSelectionUpdate(index: 1);
                          graphicColoredSheet(context);
                        },
                      ),
                      selectDesignContainer(
                        image: 'assets/Images/DesignColors/mixedColors.png',
                        isSelect: homeWatch.createTattooDesignSelection[2],
                        text: 'Mixed',
                        imageSize: 50.w,
                        selectedImage:
                            'assets/Images/DesignColors/activeStateMixedColors.png',
                        height: static.width > 550
                            ? static.width * .22
                            : static.width * .26,
                        width: static.width > 550
                            ? static.width * .22
                            : static.width * .26,
                        onTap: () {
                          homeRead.createTattooDesignSelectionUpdate(index: 2);
                          homeRead.selectRandomColorFunc();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Widget selectDesignContainer(
      {text, isSelect, image, selectedImage, imageSize, height, width, onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
            width: width ?? static.width * .26,
            height: height ?? static.width * .26,
            decoration: BoxDecoration(
                color: theme.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                    color: isSelect ? theme.orangeColor : theme.whiteColor)),
            child: Center(
              child: Image.asset(
                isSelect ? selectedImage : image,
                width: imageSize ?? static.width * .12,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: isSelect ? 1.h : 3.h,
        ),
        Text(
          text,
          style: utils.generalHeading(
              isSelect ? theme.orangeColor : theme.whiteColor.withOpacity(.7),
              size: static.width > 550 ? 10.sp : 13.sp),
        )
      ],
    );
  }

  Widget selectGraphic() {
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
            Container(
              margin: EdgeInsets.only(left: 12.w),
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Your Graphic',
                style: utils.xxlHeadingStyle(theme.whiteColor,
                    fontFamily: 'finalBold'),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0;
                      i <
                          homeWatch.mdTattooAndGraphicsGenerationModal
                              .imagesList!.length;
                      i++)
                    graphicContainer(
                      image:
                          '${homeWatch.mdTattooAndGraphicsGenerationModal.imagesList![i].url}',
                      isSelect: homeWatch.selectGraphics[i],
                      onTap: () {
                        homeRead.selectGraphicsStatusUpdate(index: i);
                      },
                    ),
                  // graphicContainer(
                  //   image: 'assets/Images/demoGraphics.png',
                  //   isSelect: homeWatch.selectGraphics[1],
                  //   onTap: () {
                  //     homeRead.selectGraphicsStatusUpdate(index: 1);
                  //   },
                  // ),
                  // graphicContainer(
                  //   image: 'assets/Images/demoGraphics2.png',
                  //   isSelect: homeWatch.selectGraphics[2],
                  //   onTap: () {
                  //     homeRead.selectGraphicsStatusUpdate(index: 2);
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget graphicContainer({image, onTap, isSelect}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
        width: static.width > 550 ? static.width * .22 : static.width * .26,
        height: static.width > 550 ? static.width * .22 : static.width * .26,
        decoration: BoxDecoration(
          color: theme.whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: CachedNetworkImage(
            width: isSelect
                ? static.width > 500
                    ? static.width * .20
                    : static.width * .24
                : static.width > 500
                    ? static.width * .18
                    : static.width * .22,
            imageUrl: '$image',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                utils.loadingShimmer(
              height:
                  static.width > 550 ? static.width * .15 : static.width * .2.w,
              width:
                  static.width > 550 ? static.width * .15 : static.width * .2.w,
            ),
            errorWidget: (context, url, error) => utils.loadingShimmer(
              height: static.width > 550
                  ? static.width * .15
                  : static.width * .18.w,
              width: static.width > 550
                  ? static.width * .15
                  : static.width * .18.w,
            ),
            fit: BoxFit.contain,
          ),

          // Image.asset(
          //   '$image',
          //   width: isSelect ? static.width * .22 : static.width * .19,
          //   fit: BoxFit.cover,
          // ),
        ),
      ),
    );
  }

  Widget createTattooButton() {
    return Container(
      width: static.width,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      child: utils.button(
        textSize: static.width > 550 ? 10.sp : 20.sp,
        text: homeWatch.isShowGraphicsContainer
            ? homeWatch.selectGraphics.contains(true)
                ? 'Awesome! Check Results'
                : 'Regenerate'
            : 'Create Your Tattoo',
        buttonColor: theme.orangeColor,
        borderColor: theme.orangeColor,
        fontFamily: 'finalBold',
        ontap: () async {
          if (homeWatch.designPromptController.text.isEmpty) {
            utils.showToast(context,
                message: 'Please Add your Design Prompt field');
          } else {
            if (homeRead.selectGraphics.contains(true) &&
                homeWatch.isShowGraphicsContainer) {

              await homeRead.sizeGroupAPi(context, isLoading: true, isFromProduct: false);
              if (homeWatch.desireTextController.text.isNotEmpty)
                await homeRead.sizeGroupAPi(context, isLoading: true, isDesireText: true);

              //.......... select Tatttoo ........//
              await homeRead.selectableTattoosAndGraphicListUpdate();
              //...................................//

              homeRead.updateImageCurrentColor(color: Colors.transparent);
              homeRead.updateColor(Colors.transparent);
              homeRead.updateSelectedFontFamilyIndex(index: 0);
              await homeRead.isImageOrTextUpdation(value: true);
              homeRead.routingForEditScreenFromTattoo(value: true);
              homeRead.updateIsFromTattoo(value: true);
              await homeRead.updateBaseColorIniatlize(Color(0xffffffff));

              Navigator.pushNamed(
                  context, route.editTattooAndProductScreenRoute);
            } else {
              homeRead.tattooAndGraphicGenerationAPi(context,
                  color: homeWatch.createTattooDesignSelection[0]
                      ? "Black & Grey"
                      : homeWatch.createTattooDesignSelection[1]
                          ? homeWatch.desireColorController.text.isNotEmpty
                              ? homeWatch.desireColorController.text
                              : "Colored"
                          : homeWatch.mixedColors.isNotEmpty
                              ? homeWatch.mixedColors
                              : "Mixed Colors");
            }
          }
        },
        textColor: theme.whiteColor,
        width: static.width,
      ),
    );
  }

  graphicColoredSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: theme.transparentColor,
        isScrollControlled: true,
        useRootNavigator: true,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  // height: static.height * 0.75,
                  child: Wrap(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50),
                            child: Container(
                              width: static.width,
                              height: static.height * 0.35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.0),
                                    topLeft: Radius.circular(12.0)),
                                color: theme.whiteColor,
                              ),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 25.h,
                                      left: 20.w,
                                      right: 20.w,
                                      bottom: 20.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Type Colors',
                                        style: utils.xxlHeadingStyleB(
                                          theme.blackColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                      ),
                                      colorTextField(),
                                      Spacer(),
                                      Container(
                                        width: static.width,
                                        child: utils.button(
                                          textSize: static.width > 550
                                              ? 10.sp
                                              : 20.sp,
                                          text: 'Save',
                                          buttonColor: theme.orangeColor,
                                          borderColor: theme.orangeColor,
                                          fontFamily: 'finalBold',
                                          ontap: () async {
                                            if (homeWatch.desireColorController
                                                .text.isNotEmpty)
                                              Navigator.pop(context);
                                          },
                                          textColor: theme.whiteColor,
                                          width: static.width,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Positioned(
                            top: 0.h,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                homeWatch.desireColorController.clear();
                                homeRead.createTattooDesignSelectionUpdate(
                                    index: 0);
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: theme.whiteColor,
                                size: 20.h,
                              ),
                            ),
                          ),
                          /*    Positioned(
                              bottom: 1,
                              child: Container(
                                width: static.width,
                                padding: EdgeInsets.only(
                                    bottom: 20.h, left: 20.w, right: 20.w,top: ),
                                child: utils.button(
                                  text: 'apply'.tr(),
                                  buttonColor: themeColor.purpleColor,
                                  borderColor: Colors.transparent,
                                  fontFamily: 'visbyCF',
                                  ontap: () {},
                                  textColor: themeColor.whiteColor,
                                  width: MediaQuery.of(context).size.width,
                                  isIcon: false,
                                ),
                              )),*/
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Widget colorTextField() {
    return Container(
      padding: EdgeInsets.only(bottom: 25.h),
      child: utils.inputField(
        textfieldColor: theme.whiteColor,
        onChange: (content) {
          // foodRead.searchFilledValueUpdate(value: true, textField: foodWatch.searchController);
        },
        borderColor: theme.greyColor.withOpacity(.7),
        textColor: theme.blackColor,
        controller: homeWatch.desireColorController,
        isEnable: true,
        isSecure: false,
        placeholder: "Color1, Color2, Color3.....",
        placeholderColor: theme.greyColor.withOpacity(.4),
      ),
    );
  }
}
