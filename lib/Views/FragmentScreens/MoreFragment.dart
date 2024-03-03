// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Helpers/FragmentHelpers/MoreFragmentHelper.dart';
import 'package:skincanvas/main.dart';

class MoreFragmentScreen extends StatefulWidget {
  @override
  State<MoreFragmentScreen> createState() => _MoreFragmentScreenState();
}

class _MoreFragmentScreenState extends State<MoreFragmentScreen> {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    setStateFunction() {
      setState(() {});
    }

    MoreFragmentHelper helper = MoreFragmentHelper(context, setStateFunction);

    return WillPopScope(
      onWillPop: () async {
        generalWatch.restrictUserNavigation == false
            ? homeRead.screenIndexUpdate(index: 0)
            : true;
        return false;
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
                  helper.settingText(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          helper.profileWidget(),
                          helper.settingWidgets(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
