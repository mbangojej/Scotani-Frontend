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

class ChangePasswordHelper {
  BuildContext context;

  ChangePasswordHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();
  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();

  Widget resetPasswordText() {
    return Container(
      width: static.width,
      child: Column(
        children: [
          utils.appBar(context, barText: 'Change Password', onPress: () {
            generalWatch.changeOldController.clear();
            generalWatch.changeNewController.clear();
            generalWatch.changeConfirmController.clear();
            Navigator.pop(context);
          }),
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
              )),
        ],
      ),
    );
  }

  Widget fieldForOldPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !generalWatch.isChangeOldVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          generalRead.changeOldVisbileUpdator(!generalWatch.isChangeOldVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.blackColor,
        placeholder: 'Current Password',
        isSecure: generalWatch.isChangeOldVisible,
        controller: generalWatch.changeOldController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForNewPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !generalWatch.isChangeNewVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          generalRead.changeNewVisbileUpdator(!generalWatch.isChangeNewVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.blackColor,
        placeholder: 'New Password',
        isSecure: generalWatch.isChangeNewVisible,
        controller: generalWatch.changeNewController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForConfirmPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !generalWatch.isChangeConfirmVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          generalRead.changeConfirmVisbileUpdator(
              !generalWatch.isChangeConfirmVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.blackColor,
        placeholder: 'Confirm Password',
        isSecure: generalWatch.isChangeConfirmVisible,
        controller: generalWatch.changeConfirmController,
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 20.sp,
            text: 'Submit',
            buttonColor: theme.orangeColor,
            borderColor: theme.orangeColor,
            fontFamily: 'finalBold',
            ontap: () async {
              if (generalWatch.changeOldController.text.isEmpty) {
                utils.showToast(context,
                    message: 'Enter your current password');
              } else if (generalWatch.changeNewController.text.isEmpty) {
                utils.showToast(context, message: 'Enter your new password');
              } else if (!regexPassword
                  .hasMatch(generalWatch.changeNewController.text)) {
                utils.showToast(context,
                    message: 'Password does not meet the required conditions.');
              } else if (generalWatch.changeConfirmController.text.isEmpty) {
                utils.showToast(context,
                    message: 'Enter your confirm password');
              } else if (generalWatch.changeNewController.text !=
                  generalWatch.changeConfirmController.text) {
                utils.showToast(context,
                    message: "New Password and Confirm Password do not match");
              } else {
                await authRead.resetPasswordApi(context,
                    email: generalWatch.emailValue,
                    newPassword: '${generalWatch.changeNewController.text}',
                    oldPassword: "${generalWatch.changeOldController.text}");
              }

              //  Navigator.push(context, MaterialPageRoute(builder:(context)=>PinputExample() ));
              // Navigator.pushNamed(context, route.loginAndSignUpRoute);
            },
            textColor: theme.whiteColor,
            width: static.width,
          ),
        ),
      ),
    );
  }
}
