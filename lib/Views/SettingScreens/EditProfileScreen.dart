import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/AuthenticationHelper/SignupHelper.dart';
import 'package:skincanvas/Helpers/SettingHelper/EditProfileHelper.dart';
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';
import 'package:skincanvas/main.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var themeColor = ThemeColors();

  var utils = AppUtils();

  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      generalWatch.editProfileImageUpdate(value: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    EditProfileHelper helper = EditProfileHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return generalWatch.restrictUserNavigation == false ? true : false;
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
                  helper.editProfileText(),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          helper.cameraWidget(),
                          SizedBox(
                            height: 30.h,
                          ),
                          helper.fieldForFullName(),
                          helper.fieldForEmail(),
                          helper.fieldForMobile(),
                          helper.fieldForAddress(),
                          helper.updateButton(),
                        ],
                      ),
                    ),
                  ),
                  utils.bottomBar(context, color: themeColor.backGroundColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
