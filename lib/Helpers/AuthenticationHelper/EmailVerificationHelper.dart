import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Models/MDErrorModal.dart';
import 'package:skincanvas/Views/Authentication/ResetPasswordScreen.dart';
import 'package:skincanvas/main.dart';

class EmailVerificationHelper {
  BuildContext context;
  SharedPreferences? myPrefs;
  Function()? setState;

  EmailVerificationHelper(this.context, this.setState);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  MDErrorModal? mdErrorModal;

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  TextEditingController codeController = TextEditingController();

  Widget emailVerificationText() {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      width: static.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
              tag: 'LoginToForgetPassword',
              child: Text(
                'Email Verification',
                style: utils.generalHeadingBold(theme.whiteColor,
                    size: static.width > 550 ? 20.sp : 26.sp,
                    fontFamily: 'finalBold'),
              )),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: theme.whiteColor,
              ),
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
    );
  }

  Widget lottieAnime() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(navigatorkey.currentContext!).size.width > 550
                      ? 90.w
                      : 70.w),
          width: static.width,
          child: Center(
            child: Lottie.asset("assets/JSON/Otp.json",
                alignment: Alignment.center),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'We have sent the OTP on \n',
                style: utils.labelStyle(
                  theme.midGreyColor,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${generalWatch.emailValue} \n' ?? '',
                    style: utils.headingStyleB(
                      theme.whiteColor,
                    ),
                  ),
                  TextSpan(
                    text: 'please verify it.',
                    style: utils.labelStyle(
                      theme.midGreyColor,
                    ),
                  )
                ]),
          ),
        ),
      ],
    );
  }

  Widget fieldForOTP() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0.h, horizontal: 20.w),
      child: PinCodeTextField(
        appContext: context,
        backgroundColor: Colors.transparent,
        textStyle: TextStyle(fontSize: 16.sp, color: theme.whiteColor),
        pastedTextStyle: TextStyle(color: theme.whiteColor),
        length: 6,
        enabled: true,
        animationCurve: Curves.linear,
        // Set to true if you want to hide the PIN digits
        animationType: AnimationType.fade,
        validator: (String? v) {
          codeController.text = v!;
          if (v!.length < 6) {
            return "";
          }
          return null; // Return null if validation is successful
        },
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8.0.r),
          fieldHeight:
              static.width > 550 ? static.width * .08 : static.width * .12,
          fieldWidth:
              static.width > 550 ? static.width * .08 : static.width * .12,
          borderWidth: 2,
          activeFillColor: theme.whiteColor,
          inactiveFillColor: theme.whiteColor,
          inactiveColor: theme.whiteColor,
          disabledColor: Colors.red,
          selectedColor: Colors.red,
          selectedFillColor: Colors.transparent,
          activeColor: Colors.red,
        ),
        cursorColor: Colors.red,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: false,
        controller: codeController,
        keyboardType: TextInputType.number,
        boxShadows: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black12,
            blurRadius: 10,
          )
        ],
        onCompleted: (v) {
          print("Completed");

          authRead.verificationEmailcontrolllerInitializer(v);
        },
        onChanged: (value) {
          print(value);
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return true;
        },
      ),
    );
  }

  Widget verifyButton() {
    return Hero(
      tag: 'LoginToSignupButton',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: static.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h) +
              EdgeInsets.only(top: 10.h),
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 20.sp,
            text: 'Verify',
            buttonColor: theme.redColor,
            borderColor: theme.redColor,
            fontFamily: 'finalBold',
            ontap: () async {
              print("length ${codeController.text.length}");

              if (codeController.text.length < 6) {
                EasyLoading.showToast('Please enter OTP code',
                    dismissOnTap: true,
                    duration: Duration(seconds: 1),
                    toastPosition: EasyLoadingToastPosition.bottom);
              } else {
                await authRead.verifyingOTPApi(context,
                    type: authWatch.forgetPasswordNavToVerified ? 2 : 1,
                    OTP: authWatch.emailVerificationController.text,
                    userID: generalWatch.userIDValue);

                if (authWatch.forgetPasswordNavToVerified && apiResponse == 1) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 1500),
                        pageBuilder: (_, __, ___) => ResetPasswordScreen()),
                  );
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

  Widget didnotReceiveCodeText() {
    return Container(
      width: static.width,
      child: Column(
        children: [
          Text(
            "Didn't receive any code?",
            style: utils.smallLabelStyle(
              theme.whiteColor.withOpacity(0.5),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          GestureDetector(
            onTap: () async {
              await authRead.resendOTPApi(context,
                  userID: generalWatch.userIDValue);
              if (apiResponse == 1) {
                codeController.text = '';
                setState;
              }
            },
            child: Text(
              'Resend New Code',
              style:
                  utils.headingStyleB(theme.redColor, fontFamily: 'finalBold'),
            ),
          ),
        ],
      ),
    );
  }
}
