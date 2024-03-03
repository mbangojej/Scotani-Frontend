import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/main.dart';

class ReportAndErrorHelper {
  BuildContext context;

  ReportAndErrorHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget reportAndErrorText() {
    return Container(
      width: static.width,
      child: Column(
        children: [
          utils.appBar(
            context,
            barText: 'Report an Error',
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
              width: static.width * .70,
              child: Text(
                'To report the error, kindly enter your information. Our team will get in touch shortly to address the issue.',
                style: utils.smallLabelStyle(
                  theme.midGreyColor,
                ),
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }

  Widget fieldForFullName() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        isEnable: false,
        placeholderColor: theme.blackColor,
        placeholder: 'Full Name',
        isSecure: false,
        controller: generalWatch.reportNameController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForEmail() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        isEnable: false,
        placeholderColor: theme.blackColor,
        placeholder: 'Your Email',
        isSecure: false,
        controller: generalWatch.reportEmailController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForPhone() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        isEnable: false,
        placeholderColor: theme.blackColor,
        placeholder: 'Your Phone',
        isSecure: false,
        controller: generalWatch.reportPhoneController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForSubject() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.blackColor,
        placeholder: 'Subject',
        isSecure: false,
        controller: generalWatch.reportSubjectController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForMessage() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.blackColor,
        placeholder: 'Write a Message',
        isSecure: false,
        controller: generalWatch.reportMessageController,
        maxLines: 6,
      ),
    );
  }

  Widget sendButton() {
    return Container(
      width: static.width,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
      margin: EdgeInsets.only(top: 15.h),
      alignment: Alignment.bottomCenter,
      child: utils.button(
        textSize: static.width > 550 ? 10.sp : 20.sp,
        text: 'Send',
        buttonColor: theme.orangeColor,
        borderColor: theme.orangeColor,
        fontFamily: 'finalBold',
        ontap: () {
          if (generalWatch.reportNameController.text.isEmpty) {
            utils.showToast(context, message: 'Enter your name');
          } else if (generalWatch.reportEmailController.text.isEmpty) {
            utils.showToast(context, message: 'Enter email address');
          } else if (!regexEmail
              .hasMatch(generalWatch.reportEmailController.text)) {
            utils.showToast(context, message: 'Enter valid email');
          } else if (generalWatch.reportPhoneController.text.isEmpty) {
            utils.showToast(context,
                message: 'Enter phone number with country code');
          } else if (generalWatch.reportSubjectController.text.isEmpty) {
            utils.showToast(context, message: 'Please enter subject');
          } else if (!regexReportAndError
              .hasMatch(generalWatch.reportSubjectController.text)) {
            utils.showToast(context, message: 'Please enter valid subject');
          } else if (generalWatch.reportMessageController.text.isEmpty) {
            utils.showToast(context, message: 'Please enter message');
          } else if (!regexReportAndError
              .hasMatch(generalWatch.reportMessageController.text)) {
            utils.showToast(context, message: 'Please enter some valid reason');
          } else {
            generalRead.reportAndErrorApi(context);
          }
        },
        textColor: theme.whiteColor,
        width: static.width,
      ),
    );
  }
}
