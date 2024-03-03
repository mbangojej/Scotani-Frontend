import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';

import 'package:skincanvas/Views/Authentication/ForgetPasswordScreen.dart';
import 'package:skincanvas/Views/Authentication/SignupScreen.dart';
import 'package:skincanvas/main.dart';

class LoginHelper {
  BuildContext context;

  LoginHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

//
// Login
//
  Widget loginText() {
    return Container(
      padding: EdgeInsets.only(top: 30.h),
      width: static.width,
      child: Column(
        children: [
          Hero(
            tag: 'LoginSignUp',
            child: Text(
              'Login',
              style: utils.generalHeadingBold(theme.whiteColor,
                  size: static.width > 550 ? 20.sp : 26.sp,
                  fontFamily: 'finalBold'),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            'Add your details to login',
            style: utils.smallLabelStyle(
              theme.midGreyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldForEmail() {
    return Hero(
      tag: 'LoginToSignup',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: utils.inputField(
            keyboard: TextInputType.emailAddress,
            textColor: theme.blackColor,
            postfixIcon: null,
            postfixClick: () async {},
            postfixIconColor: null,
            placeholderColor: theme.blackColor.withOpacity(.7),
            placeholder: 'Your Email',
            isSecure: false,
            controller: authWatch.loginEmailController,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Widget fieldForPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !authWatch.isLoginPassVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          authRead.loginPasswordUpdator(!authWatch.isLoginPassVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.blackColor.withOpacity(.7),
        placeholder: 'Your Password',
        isSecure: authWatch.isLoginPassVisible,
        controller: authWatch.loginPasswordController,
        maxLines: 1,
      ),
    );
  }

  Widget forgotPassword() {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, route.forgetPasswordScreenRoute);
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1500),
                pageBuilder: (_, __, ___) => ForgetPasswordScreen()));
      },
      child: Hero(
        tag: 'LoginToForgetPassword',
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 6.h),
            alignment: Alignment.center,
            child: Text(
              'Forgot your password?',
              style: utils.labelStyle(theme.whiteColor),
            )),
      ),
    );
  }

  Widget RememberMe() {
    return GestureDetector(
      onTap: () {
        authRead.rememberMeUpdator(
            value: !authWatch.isRemember,
            email: authWatch.loginEmailController.text,
            password: authWatch.loginPasswordController.text);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            authWatch.isRemember
                ? Image.asset('assets/Icons/checked.png',
                    height: static.width > 412 ? 14.h : 20.h,
                    width: static.width > 412 ? 14.w : 20.w,
                    color: theme.redColor)
                : Image.asset(
                    'assets/Icons/unChecked.png',
                    height: static.width > 412 ? 14.h : 20.h,
                    width: static.width > 412 ? 14.w : 20.w,
                    color: theme.whiteColor.withOpacity(.6),
                  ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              'Remember me',
              style: authWatch.isRemember
                  ? utils.labelStyle(theme.whiteColor)
                  : utils.smallLabelStyle(theme.whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
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
            vertical: 18.h,
          ),
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 20.sp,
            text: 'Login',
            buttonColor: theme.redColor,
            borderColor: theme.redColor,
            fontFamily: 'finalBold',
            ontap: () async {
              if (authWatch.loginEmailController.text.isEmpty) {
                utils.showToast(context, message: 'Please fill email field');
              } else if (!regexEmail
                  .hasMatch(authWatch.loginEmailController.text)) {
                utils.showToast(context, message: 'Please enter valid email');
              } else if (authWatch.loginPasswordController.text.isEmpty) {
                utils.showToast(context, message: 'Please fill password field');
              } else {
                await authRead.rememberMeUpdator(
                    value: authWatch.isRemember,
                    email: authWatch.loginEmailController.text,
                    password: authWatch.loginPasswordController.text);
                await authRead.signInApi(context);
              }
            },
            textColor: theme.whiteColor,
            width: static.width,
          ),
        ),
      ),
    );
  }

  dontHaveAccountText() {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, route.signUpScreenRoute);
        // Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //         transitionDuration: Duration(milliseconds: 1500),
        //         pageBuilder: (_, __, ___) => SignUpScreen(
        //               isFromLogin: true,
        //             )));
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => SignUpScreen(
              isFromLogin: true,
            ),
            // Replace with your desired destination screen
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-0.18, 0.0); // Start from left
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 20.h),
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
              text: 'Don’t have an Account? ',
              style: utils.labelStyle(
                theme.whiteColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Sign Up',
                  style: utils.labelStyleB(
                    theme.redColor,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
