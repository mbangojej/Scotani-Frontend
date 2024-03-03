import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Helpers/PlaceOrderHelper/PlaceOrderHelper.dart';
import 'package:skincanvas/main.dart';

class PlaceOrderScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var generalWatch = Provider.of<GeneralController>(navigatorkey.currentContext!, listen: false);

  @override
  Widget build(BuildContext context) {
    PlaceOrderHelper helper = PlaceOrderHelper(context);

    return WillPopScope(
      onWillPop: () async {
        return generalWatch.restrictUserNavigation == false ? true :  false;
      },
      child: Scaffold(
        backgroundColor: themeColor.orangeColor,
        body: InternetConnectivityScreen(
          widget: Container(
            width: static.width,
            height: static.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                utils.statusBar(context, color: themeColor.backGroundColor),
                helper.placeOrderText(),
                helper.designPrompt(),
                SizedBox(
                  height: 5.h,
                ),
                helper.selectBodyArea(),
                helper.CartButton(),
                utils.bottomBar(context, color: themeColor.backGroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
