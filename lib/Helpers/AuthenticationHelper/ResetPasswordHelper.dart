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
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/main.dart';

class ResetPasswordHelper {
  BuildContext context;

  ResetPasswordHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  MDErrorModal? mdErrorModal;

  Widget resetPasswordText() {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      width: static.width,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Hero(
                  tag: 'LoginSignUp',
                  child: Text(
                    'New Password',
                    style: utils.generalHeadingBold(theme.whiteColor,
                        size: static.width > 550 ? 20.sp : 26.sp,
                        fontFamily: 'finalBold'),
                  )),
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.back, color: theme.whiteColor),
                  // Icon to display
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // Callback function when pressed
                  tooltip: 'Like', // Optional tooltip text
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          Container(
            width: static.width * .70,
            child: Text(
              'Passwords need to be minimum 8 characters long with uppercase, lowercase, a number, and a special character.',
              style: utils.smallLabelStyle(
                theme.midGreyColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldForNewPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !authWatch.resetNewPassVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          authRead.resetPasswordUpdator(
              confirmPass: authWatch.resetConfirmPassVisible,
              newPass: !authWatch.resetNewPassVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.midGreyColor.withOpacity(.7),
        placeholder: 'New Password',
        isSecure: authWatch.resetNewPassVisible,
        controller: authWatch.resetNewPController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForConfirmPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !authWatch.resetConfirmPassVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          authRead.resetPasswordUpdator(
              confirmPass: !authWatch.resetConfirmPassVisible,
              newPass: authWatch.resetNewPassVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.midGreyColor.withOpacity(.7),
        placeholder: 'Confirm Password',
        isSecure: authWatch.resetConfirmPassVisible,
        controller: authWatch.resetConfirmController,
        maxLines: 1,
      ),
    );
  }

  Widget submitButton() {
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
            text: 'Submit',
            buttonColor: theme.orangeColor,
            borderColor: theme.orangeColor,
            fontFamily: 'finalBold',
            ontap: () async {
              if (authWatch.resetNewPController.text.isEmpty) {
                utils.showToast(context, message: 'Enter new password');
              } else if (!regexPassword
                  .hasMatch(authWatch.resetNewPController.text)) {
                utils.showToast(context,
                    message:
                        'Entered password does not meet the required conditions');
              } else if (authWatch.resetNewPController.text !=
                  authWatch.resetConfirmController.text) {
                utils.showToast(context,
                    message: "New Password and Confirm Password do not match.");
              } else {
                await authRead.resetPasswordApi(context,
                    email: authWatch.forgetPasswordController.text,
                    newPassword: '${authWatch.resetNewPController.text}');

                print(
                    "${authWatch.forgetPasswordNavToVerified} + ${apiResponse}");

                if (authWatch.forgetPasswordNavToVerified && apiResponse == 1) {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 1500),
                          pageBuilder: (_, __, ___) => LoginAndSignUpScreen()));
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
