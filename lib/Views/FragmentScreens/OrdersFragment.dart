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
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Helpers/FragmentHelpers/OrdersFragmentHelper.dart';
import 'package:skincanvas/main.dart';

class OrdersFragmentScreen extends StatelessWidget {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  ScrollController scrollController = ScrollController();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  @override
  Widget build(BuildContext context) {
    OrdersFragmentHelper helper =
        OrdersFragmentHelper(context, scrollController);

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
          resizeToAvoidBottomInset: false,
          backgroundColor: themeColor.backGroundColor,
          body: InternetConnectivityScreen(
            widget: Container(
              width: static.width,
              height: static.height,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  helper.orderHistoryText(),
                  helper.fieldForSearch(),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: helper.OrderHistory(),
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
