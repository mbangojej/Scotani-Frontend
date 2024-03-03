import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Models/MDErrorModal.dart';
import 'package:skincanvas/Views/Authentication/EmailVerificaitonScreen.dart';
import 'package:skincanvas/main.dart';

class ForgetPasswordHelper {
  BuildContext context;

  ForgetPasswordHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  Widget forgetPasswordText() {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      width: static.width,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                  tag: 'LoginToForgetPassword',
                  child: Text(
                    'Forgot Password',
                    style: utils.generalHeadingBold(theme.whiteColor,
                        size: static.width > 550 ? 20.sp : 26.sp,
                        fontFamily: 'finalBold'),
                  )),
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.back),
                  color: theme.whiteColor,
                  onPressed: () {
                    authWatch.forgetPasswordController.clear();
                    Navigator.pop(context);
                  }, // Callback function when pressed
                  tooltip: 'Like', // Optional tooltip text
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
              child: Text(
            'Please enter your email to receive a \n link via email to create a new password',
            style: utils.smallLabelStyle(
              theme.midGreyColor,
            ),
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }

  Widget fieldForEmail() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        keyboard: TextInputType.emailAddress,
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.blackColor,
        placeholder: 'Your Email',
        isSecure: false,
        controller: authWatch.forgetPasswordController,
        maxLines: 1,
      ),
    );
  }

  Widget sendButton() {
    return Hero(
      tag: 'LoginToSignupButton',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: static.width,
          padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(navigatorkey.currentContext!).size.width > 550
                      ? 12.w
                      : 15.w,
              vertical: 18.h),
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 20.sp,
            text: 'Send',
            buttonColor: theme.orangeColor,
            borderColor: theme.orangeColor,
            fontFamily: 'finalBold',
            ontap: () async {
              if (authWatch.forgetPasswordController.text.isEmpty) {
                utils.showToast(context, message: 'Please fill Email field');
              } else if (!regexEmail
                  .hasMatch(authWatch.forgetPasswordController.text)) {
                utils.showToast(context, message: 'Please enter valid Email');
              } else {
                await authRead.forgetPasswordApi(context,
                    email: authWatch.forgetPasswordController.text);

                if (authWatch.forgetPasswordNavToVerified && apiResponse == 1) {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1500),
                          pageBuilder: (_, __, ___) =>
                              EmailVerificationScreen()));
                }
              }
            },
            textColor: theme.whiteColor,
            width: static.width,
          ),
        ),
      ),
    );
  }
}
