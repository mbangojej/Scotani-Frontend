import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/EmailVerificationHelper.dart';
import 'package:skincanvas/Views/Authentication/ForgetPasswordScreen.dart';
import 'package:skincanvas/main.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  var themeColor = ThemeColors();

  var utils = AppUtils();

  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(navigatorkey.currentContext!, listen: false);


  @override
  Widget build(BuildContext context) {

    setStateFunction(){
      setState(() {

      });
    }
    EmailVerificationHelper helper = EmailVerificationHelper(context,setStateFunction);

    return WillPopScope(
      onWillPop: () async {
        if(generalWatch.restrictUserNavigation == false) {
          if (navigatorkey.currentContext!
              .watch<AuthenticationController>()
              .forgetPasswordNavToVerified) {
            return await Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 1500),
                    pageBuilder: (_, __, ___) => ForgetPasswordScreen()));
          }

          return false;
        }
        else{
          return false;
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: themeColor.backGroundColor,
          body: InternetConnectivityScreen(
            widget: Container(
                width: static.width,
                height: static.height,
                child: Column(
                  children: [
                    utils.statusBar(context, color: themeColor.backGroundColor),
                    helper.emailVerificationText(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            helper.lottieAnime(),
                            helper.fieldForOTP(),
                            helper.verifyButton(),
                          ],
                        ),
                      ),
                    ),
                    helper.didnotReceiveCodeText(),
                    SizedBox(
                      height: 20.h,
                    ),
                    utils.bottomBar(context, color: themeColor.backGroundColor),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
