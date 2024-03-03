import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/Widgets/ProfileWidget.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/main.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  var static = Statics();
  var themeColor = ThemeColors();

  //.................. Text Styles/Sizes Define .........//
  generalHeadingBold(color,
      {size = 0.0, fontFamily = 'finalBook', weight = FontWeight.bold}) {
    return TextStyle(
      fontWeight: static.bold,
      fontSize: MediaQuery.of(navigatorkey.currentContext!).size.width > 412
          ? size
          : size - 2.sp,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  generalHeading(color,
      {size = 0.0, fontFamily = 'finalBook', weight = FontWeight.normal}) {
    return TextStyle(
      fontWeight: static.normal,
      fontSize: MediaQuery.of(navigatorkey.currentContext!).size.width > 412
          ? size
          : size - 2.sp,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xxlHeadingStyle(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontWeight: static.normal,
      fontSize: static.xxlHeading,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xxlHeadingStyleB(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontWeight: static.bold,
      fontSize: static.xxlHeading,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xlHeadingStyle(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontWeight: static.normal,
      fontSize: static.xlHeading,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xlHeadingStyleB(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontWeight: static.bold,
      fontSize: static.xlHeading,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xHeadingStyle(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontWeight: static.light,
      fontSize: static.xHeading,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xHeadingStyleB(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontWeight: static.bold,
      fontSize: static.xHeading,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  headingStyle(color,
      {fontFamily = 'finalBook', textDecoration = TextDecoration.none}) {
    return TextStyle(
      fontWeight: static.normal,
      fontSize: static.heading,
      color: color,
      decoration: textDecoration,
      fontFamily: fontFamily,
      decorationThickness: 2,
      height: 1.4,
    );
  }

  headingStyleB(color,
      {fontFamily = 'finalBook', textDecoration = TextDecoration.none}) {
    return TextStyle(
      fontWeight: static.bold,
      fontSize: static.heading,
      color: color,
      decoration: textDecoration,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  labelStyle(
    color, {
    fontFamily = 'finalBook',
    textDecoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontSize: static.label,
      fontWeight: static.normal,
      color: color,
      decoration: textDecoration,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  labelStyleSize(
    color, {
    fontFamily = 'finalBook',
    textDecoration = TextDecoration.none,
  }) {
    return TextStyle(
      fontSize: static.label,
      fontWeight: static.normal,
      color: color,
      decoration: textDecoration,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  labelStyleB(color,
      {fontFamily = 'finalBook', textDecoration = TextDecoration.none}) {
    return TextStyle(
      fontSize: static.label,
      fontWeight: static.bold,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      decorationThickness: 2,
      height: 1.4,
    );
  }

  smallLabelStyle(
    color, {
    fontFamily = 'finalBook',
    textDecoration = TextDecoration.none,
    height = 1.4,
    letterSpacing = 0.0,
  }) {
    return TextStyle(
      fontSize: static.smallLabel,
      fontWeight: static.normal,
      color: color,
      decoration: textDecoration,
      fontFamily: fontFamily,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

  smallLabelStyleB(color, {fontFamily = 'finalBook', height = 1.4}) {
    return TextStyle(
      fontSize: static.smallLabel,
      fontWeight: static.bold,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: height,
    );
  }

  xSmallLabelStyle(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontSize: static.xSmallLabel,
      fontWeight: static.normal,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xSmallLabelStyleB(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontSize: static.xSmallLabel,
      fontWeight: static.bold,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xlSmallLabelStyle(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontSize: static.xlSmallLabel,
      fontWeight: static.normal,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xlSmallLabelStyleB(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontSize: static.xlSmallLabel,
      fontWeight: static.bold,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xxlSmallLabelStyle(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontSize: static.xxlSmallLabel,
      fontWeight: static.normal,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  xxlSmallLabelStyleB(color, {fontFamily = 'finalBook'}) {
    return TextStyle(
      fontSize: static.xxlSmallLabel,
      fontWeight: static.bold,
      color: color,
      decoration: TextDecoration.none,
      fontFamily: fontFamily,
      height: 1.4,
    );
  }

  statusBar(context, {color}) {
    return Container(
      height: MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  Widget bottomBar(context, {color}) {
    return Container(
      height: MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }

  Widget appBar(
    context, {
    barText,
    rightText = '',
    VoidCallback? onPress, // Added parameter with default value of null
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      width: static.width,
      color: themeColor.lightBlackColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '$barText',
            style: generalHeadingBold(themeColor.whiteColor,
                size: static.width > 550 ? 20.sp : 26.sp,
                fontFamily: 'finalBold'),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: themeColor.whiteColor,
              ),
              onPressed: onPress ?? () => Navigator.pop(context),
              // Use provided onPress or default Navigator.pop
              tooltip: 'Back', // Optional tooltip text
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '$rightText',
              style: generalHeadingBold(themeColor.whiteColor,
                  size: static.width > 550 ? 20.sp : 26.sp,
                  fontFamily: 'finalBold'),
            ),
          ),
        ],
      ),
    );
  }

  button({
    textColor,
    text,
    textSize = 0.0,
    buttonColor,
    borderColor,
    ontap,
    fontFamily = "finalBook",
    width = 423,
  }) {
    return InkWell(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: borderColor, width: .7),
        ),
        child: Text(
          text,
          style: generalHeadingBold(textColor,
              fontFamily: fontFamily, size: textSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  inputField({
    isEnable = true,
    textColor,
    placeholder,
    placeholderColor,
    postfixIcon,
    postfixIconColor,
    postFixIconSize = 20.0,
    postfixClick,
    prefixIcon,
    prefixIconColor,
    preFixIconSize = 20.0,
    prefixClick,
    maxLines = 1,
    isSecure,
    controller,
    keyboard = TextInputType.text,
    textfieldColor = null,
    borderColor = null,
    onChange = null,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 2.w) +
              EdgeInsets.only(right: 12.w),
          margin: EdgeInsets.symmetric(vertical: 7.h),
          decoration: BoxDecoration(
              color: textfieldColor ?? themeColor.lightGreyColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: borderColor ?? Colors.transparent,
                width: 0.5,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (prefixIcon != null)
                GestureDetector(
                  onTap: prefixClick,
                  child: Container(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Image.asset(
                      "assets/Icons/$prefixIcon.png",
                      height: preFixIconSize,
                      width: preFixIconSize,
                      color: prefixIconColor,
                    ),
                  ),
                ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: TextFormField(
                    onChanged: onChange,
                    enabled: isEnable,
                    controller: controller,
                    maxLines: maxLines,
                    keyboardType: keyboard,
                    obscureText: isSecure,
                    style: headingStyle(textColor),
                    cursorColor: themeColor.orangeColor,
                    decoration: InputDecoration.collapsed(
                      hintText: placeholder,
                      hintStyle: headingStyle(
                        placeholderColor,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              if (postfixIcon != null)
                GestureDetector(
                  onTap: postfixClick,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 7.0),
                    child: Image.asset(
                      "assets/Icons/$postfixIcon.png",
                      height: postFixIconSize,
                      width: postFixIconSize,
                      color: postfixIconColor,
                    ),
                  ),
                )
            ],
          )),
    );
  }

  categorySelectionContainer({
    isNetwork = true,
    isFromCreateProduct = false,
    image,
    text,
    textSize,
    isSelect,
    height,
    width,
    imageSize,
    imageColor,
    onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
        width: width ?? static.width * .26,
        height: height ?? static.width * .26,
        decoration: BoxDecoration(
            color: themeColor.lightBlackColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color:
                    isSelect ? themeColor.orangeColor : themeColor.greyColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isNetwork
                ? CachedNetworkImage(
                    width: imageSize ?? static.width * .12,
                    imageUrl: "${image}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => loadingShimmer(
                      width: static.width * .12,
                      height: static.width * .12,
                    ),
                    errorWidget: (context, url, error) => loadingShimmer(
                      width: static.width * .12,
                      height: static.width * .12,
                    ),
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    '$image',
                    width: imageSize,
                    color: imageColor ?? themeColor.whiteColor,
                  ),
            isFromCreateProduct
                ? SizedBox(
                    height: 10.h,
                  )
                : SizedBox(
                    height: 4.h,
                  ),
            Text(
              text,
              style: generalHeading(
                isSelect
                    ? themeColor.orangeColor
                    : themeColor.whiteColor.withOpacity(.7),
                size: textSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  fontFamilySelectionContainer({
    text,
    textSize,
    fontFamily,
    index,
    selectedIndex,
    height,
    width,
    onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
        width: width ?? static.width * .26,
        height: height ?? static.width * .26,
        decoration: BoxDecoration(
            color: themeColor.lightBlackColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
                color: selectedIndex == index
                    ? themeColor.orangeColor
                    : themeColor.greyColor)),
        child: Center(
          child: Text(
            text,
            style: generalHeading(
              selectedIndex == index
                  ? themeColor.orangeColor
                  : themeColor.whiteColor.withOpacity(.7),
              size: textSize,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  imageSelectionDialogBox(BuildContext buildContext,
      {onTapCamera, onTapGallery}) {
    showDialog(
        context: buildContext,
        builder: (context) => AlertDialog(
              backgroundColor: themeColor.orangeColor,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  height: static.height * .27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: themeColor.orangeColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onTapCamera,
                            child: Container(
                              child: containerForDialogBox(
                                  "assets/Icons/cameraFilled.png", "Camera"),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: onTapGallery,
                            child: Container(
                              child: containerForDialogBox(
                                  "assets/Icons/galleryFilled.png", "Gallery"),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ));
  }

  containerForDialogBox(pic, text) {
    return Column(
      children: [
        Center(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
          decoration: BoxDecoration(
            color: themeColor.whiteColor,
            shape: BoxShape.circle,
          ),
          child: Container(
            width: static.width * .10,
            height: static.height * .06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              pic,
              fit: BoxFit.contain,
              color: themeColor.orangeColor,
            ),
          ),
        )),
        SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: headingStyleB(
            themeColor.whiteColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  //........... Loading Shimmer and Toast.........//

  showToast(context, {message}) {
    return Fluttertoast.showToast(
      msg: message ?? "",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: themeColor.redColor,
      fontSize: static.width > 500 ? 12.sp : 16.0.sp,
    );
  }

  apiResponseToast({message, stayTime = 3}) {
    return EasyLoading.showToast('$message',
        dismissOnTap: true,
        duration: Duration(seconds: stayTime),
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  loadingShimmer(
      {image = '',
      height = 0.0,
      width = 0.0,
      color = Colors.white,
      boxFit = BoxFit.contain}) {
    return Container(
      child: Shimmer.fromColors(
          child: Center(
            child: Image.asset(
              "assets/Images/appLogo.png",
              color: color,
              fit: boxFit,
              height: height,
              width: width,
            ),
          ),
          baseColor: Colors.grey[500]!,
          highlightColor: Colors.grey[100]!),
    );
  }

  genericDialog(context,
      {heading,
      headingTextColor,
      negativeAction,
      positiveAction,
      negativeActionText,
      positiveActionText,
      dialogColor}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: SingleChildScrollView(
          child: Container(
            width: static.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: dialogColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Text(
                    heading,
                    style: xHeadingStyleB(headingTextColor,
                        fontFamily: 'finalBold'),
                  ),
                ),
                SizedBox(height: 5.h),
                Container(
                  margin: EdgeInsets.only(right: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: negativeAction,
                        child: Text(
                          '${negativeActionText}',
                          style: headingStyleB(themeColor.whiteColor),
                        ),
                      ),
                      TextButton(
                        onPressed: positiveAction,
                        child: Text(
                          '${positiveActionText}',
                          style: headingStyleB(themeColor.orangeColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  exitingAppDialog(context,
      {icon,
      heading,
      headingTextColor,
      message,
      positiveButton,
      negativeButton,
      positiveAction,
      negativeAction,
      dialogColor}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero, // Remove default padding
        content: SingleChildScrollView(
            child: Container(
          width: static.width,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.r), color: dialogColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Lottie.asset("assets/JSON/$icon.json",
                          height: 50.h,
                          width: 50.w,
                          alignment: Alignment.center),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      heading,
                      style: xlHeadingStyleB(headingTextColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      message,
                      style: headingStyle(headingTextColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                width: static.width,
                height: 1,
                color: headingTextColor.withOpacity(0.3),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                          onTap: negativeAction,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            alignment: Alignment.center,
                            child: Text(
                              negativeButton,
                              style: headingStyleB(headingTextColor),
                            ),
                          )),
                    ),
                    if (positiveAction != null)
                      Container(
                        width: 1,
                        color: headingTextColor.withOpacity(0.3),
                      ),
                    if (positiveAction != null)
                      Expanded(
                        child: InkWell(
                          onTap: positiveAction,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            alignment: Alignment.center,
                            child: Text(
                              positiveButton,
                              style: headingStyleB(headingTextColor),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  Future<bool> requestLocationPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  String convertHtmlToPlainText(String htmlData) {
    var doc = parse(htmlData);
    if (doc.documentElement != null) {
      String parsedstring = doc.documentElement!.text;
      print(parsedstring);
      //output without space: HelloThis is fluttercampus.com,Bye!
      return parsedstring;
    }
    return '';
  }

  categoriesShimmer() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            width: static.width > 550 ? static.width * .20 : static.width * .23,
            height:
                static.width > 550 ? static.width * .22 : static.width * .26,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: themeColor.whiteColor),
            child: Container(
              child: Shimmer.fromColors(
                  child: Center(
                    child: Image.asset(
                      "assets/Images/appLogo.png",
                      color: themeColor.orangeColor,
                      fit: BoxFit.contain,
                      width: static.width * .18,
                      height: static.width * .18,
                    ),
                  ),
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Shimmer.fromColors(
              child: Text(
                'SCOTANI',
                style: labelStyle(
                  themeColor.whiteColor,
                ),
              ),
              baseColor: Colors.grey[700]!,
              highlightColor: Colors.grey[100]!),
        ],
      ),
    );
  }

  productShimmer() {
    return Container(
      width: static.width > 500 ? static.width * .45 : static.width * .46,
      height: static.width > 500 ? static.height * .42 : static.height * .35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: themeColor.transparentColor,
      ),
      margin:
          EdgeInsets.only(bottom: 10.h) + EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: themeColor.transparentColor,
                  ),
                  color: themeColor.whiteColor),
              child: Shimmer.fromColors(
                  child: Center(
                    child: Image.asset(
                      "assets/Images/appLogo.png",
                      color: themeColor.orangeColor,
                      fit: BoxFit.contain,
                      width: static.width * .3,
                      height: static.width * .3,
                    ),
                  ),
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Container(
            padding: EdgeInsets.only(left: 10.w),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                    child: Text(
                      'SCOTANI',
                      style: smallLabelStyle(
                        themeColor.whiteColor.withOpacity(.8),
                      ),
                    ),
                    baseColor: Colors.grey[700]!,
                    highlightColor: Colors.grey[100]!),
                SizedBox(height: 2.h),
                Shimmer.fromColors(
                    child: Text(
                      '\$0.0',
                      style: smallLabelStyle(
                        themeColor.orangeColor.withOpacity(.8),
                      ),
                    ),
                    baseColor: Colors.grey[700]!,
                    highlightColor: Colors.grey[100]!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  noDataFound({text = 'No Data Exist !'}) {
    return Container(
      padding: EdgeInsets.only(top: 50.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/JSON/noodedLottie.json",
              height: 80.h, width: 80.w, alignment: Alignment.center),
          Text(
            '$text',
            style:
                xHeadingStyleB(themeColor.whiteColor, fontFamily: 'finalBold'),
          ),
        ],
      ),
    );
  }

  String? splitImageName({imageURL}) {
    // Your image URL
    String image = imageURL;

    // Use the Uri class to parse the URL
    Uri uri = Uri.parse(image);

    String imagePath = uri.path;
    List<String> pathSegments = imagePath.split('/');
    String imageName = pathSegments.last;

    print("Image Name: $imageName");

    return imageName;
  }

  flipCard(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            backgroundColor: themeColor.transparentColor,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlipCard(
                    flipOnTouch: false,
                    fill: Fill.fillBack,
                    // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.HORIZONTAL,
                    // default
                    front: ProfileDetailContainer(),
                    back: Container(
                      child: Container(),
                    ),
                  )
                ],
              ),
            )));
  }

  profileDataConatiner({label, desription, icon}) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        size: static.width > 550 ? 12.w : 18.w,
                        color: themeColor.orangeColor,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          label,
                          style: labelStyleB(
                              themeColor.blackColor.withOpacity(.8),
                              fontFamily: 'light'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                    padding: EdgeInsets.only(left: 20.w, right: 10.w),
                    child: Text(
                      desription.toString(),
                      style: labelStyle(themeColor.blackColor.withOpacity(.6),
                          fontFamily: 'light'),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  Future<String> urlToBase64(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final base64String = base64Encode(bytes);
      return base64String;
    } else {
      throw Exception('Failed to load image');
    }
  }

  base64ToBytes(String base64String) {
    Uint8List bytes = Base64Decoder().convert(base64String);
    return bytes;
  }

  updateCapturedImage(
    context, {
    List<Uint8List>? images,
  }) async {
    List listOfData = [];

    for (int i = 0; i < images!.length; i++) {
      Uint8List capturedSampleImage = images[i];
      print('Images = ${capturedSampleImage}');

      final tempDirectory = await getTemporaryDirectory();
      final imageFile = File('${tempDirectory.path}/sampleImage.png');
      await imageFile.writeAsBytes(capturedSampleImage);

      if (navigatorkey.currentContext!
          .read<HomeController>()
          .selectGraphics[i]) {
        var image = await navigatorkey.currentContext!
            .read<HomeController>()
            .uploadImageApi(context, type: '', file: imageFile);
        listOfData.add(image);
      }
    }

    print("The images data is:" + listOfData.toString());

    return listOfData;
  }

  String timeStampToTime({inputTimestamp}) {
    DateTime parsedDateTime = DateTime.parse(inputTimestamp);
    String formattedDate =
        "${_getMonthName(parsedDateTime.month)} ${parsedDateTime.day}, ${parsedDateTime.year}";

    print(formattedDate); // Output: June 18, 2023

    return formattedDate;
  }

  String _getMonthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }

  Color hexToColor(String code) {
    if (code == null) return Colors.transparent;
    String cleanCode = code.replaceAll("#", "");
    int colorValue = int.parse("0xff$cleanCode");
    return Color(colorValue);
  }

  String colorToHex(Color color) {
    return '#' + color.value.toRadixString(16).padLeft(8, '0').substring(2);
  }

  aboutUsIconsInfo({image, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        "assets/Icons/$image.png",
        fit: BoxFit.cover,
        height: 32.w,
        width: 32.w,
      ),
    );
  }

  //......................... For Url Launch Function ....................... ///
  Future<void> openUrl(String url) async {
    if (url.contains('@')) {
      // Assuming it's an email
      url = 'mailto:$url';
    } else if (url.startsWith('+') ||
        (url.length >= 10 &&
            url.length <= 15 &&
            url.replaceAll(RegExp(r'[^\d]'), '').length == url.length)) {
      // Assuming it's a phone number
      url = 'tel:+$url';
    } else {
      // For all other links, assuming direct URLs
      url = url;
    }

    final _url = Uri.parse(url);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      // <--
      throw ('Successfully Launched');
    } else {
      throw Exception('Could not launch $_url');
    }
  }

  notificationDetailDialogBox(BuildContext buildContext, {orderStatus, text}) {
    showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: themeColor.whiteColor,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          width: double.infinity,
          height: static.height * .24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: themeColor.whiteColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${orderStatus}',
                style: headingStyleB(themeColor.orangeColor),
              ),
              SizedBox(
                height: 3.h,
              ),
              Divider(
                color: themeColor.midGreyColor,
              ),
              SizedBox(
                height: 3.h,
              ),
              Container(
                height: static.height * 0.10,
                child: SingleChildScrollView(
                  child: Text(
                    '${text}',
                    style: headingStyle(themeColor.blackColor),
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.bottomRight,
                    height: 30.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: themeColor.orangeColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        "OK",
                        style: labelStyleB(themeColor.whiteColor),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  convertUTCToCurrentDate({dateString}) {
    print('date String ${dateString}');

    DateTime utcDateTime = DateTime.parse(dateString);
    DateTime localDateTime = utcDateTime.toLocal();
    String formattedDate = DateFormat('y-MM-dd').format(localDateTime);

    print('UTC: $utcDateTime');
    print('Local: $localDateTime');

    return formattedDate.toString();
  }
}
