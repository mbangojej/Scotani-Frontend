// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Helpers/FragmentHelpers/HomeFragmentHelper.dart';
import 'package:skincanvas/Services/OrdersCheckoutWishlistServices.dart';
import 'package:skincanvas/main.dart';

class HomeFragmentScreen extends StatefulWidget {
  @override
  State<HomeFragmentScreen> createState() => _HomeFragmentScreenState();
}

class _HomeFragmentScreenState extends State<HomeFragmentScreen>
    with TickerProviderStateMixin {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  late TabController _tabController;
  ScrollController scrollController = ScrollController();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  var generalWatch = navigatorkey.currentContext!.read<GeneralController>();

  var orderRead =
      navigatorkey.currentContext!.read<OrderCheckOutWishlistController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      apis(isRefresh: false);
      // homeRead.categoryStatusInitialize();
    });
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeFragmentHelper helper =
        HomeFragmentHelper(context, _tabController, scrollController);
    return WillPopScope(
      onWillPop: () async {
        if (generalWatch.restrictUserNavigation == false) {
          print("onWillPop triggered");
          homeRead.screenIndexUpdate(index: 0);
          print("Screen index updated to ${homeRead.screenIndex}");
          if (homeWatch.screenIndex == 0) {
            print("Screen index home ${homeRead.screenIndex}");
            await AppUtils().exitingAppDialog(context,
                headingTextColor: themeColor.blackColor,
                dialogColor: themeColor.whiteColor,
                icon: 'alertAnime',
                heading: 'Alert',
                message: "Are you sure you want to quit the app?",
                positiveButton: 'Yes',
                negativeButton: 'No', positiveAction: () {
              exit(0);
            }, negativeAction: () {
              Navigator.pop(context);
            });
          }
        }

        return generalWatch.restrictUserNavigation == false ? true : false;
      },
      child:
          // RefreshIndicator(
          //   backgroundColor: themeColor.orangeColor,
          //   color: themeColor.blackColor,
          //   onRefresh: () async {
          //     await apis(isRefresh: true);
          //   },
          //   child:
          Scaffold(
        backgroundColor: themeColor.backGroundColor,
        resizeToAvoidBottomInset: false,
        body: InternetConnectivityScreen(
          widget: Container(
            width: static.width,
            height: static.height,
            child: Column(
              children: [
                SizedBox(
                  height: 15.h,
                ),
                helper.appBar(),
                SizedBox(
                  height: 10.h,
                ),
                helper.fieldForSearch(),
                helper.tabs(),
                Expanded(
                  child: helper.tabView(),
                ),
              ],
            ),
          ),
        ),
      ),
      // ),
    );
  }

  apis({isRefresh = false}) async {
    if (isRefresh == false) {
      setState(() {
        _tabController.index = 0;
      });
      getCMSData();
    } else {
      setState(() {
        _tabController.index = _tabController.index;
      });
    }

    await orderRead.cartListingApi(context, isLoading: false, isRoute: false);

    await homeRead.categoryListingApi(context,
        type: '0', title: '', isLoading: !isRefresh);

    await homeRead.selectedCategoryUpdator(
        index: 0, ID: homeWatch.categoryList[0].sId.toString(), type: '0');

    // SharedPreferences myPrefs = await SharedPreferences.getInstance();

    // notificationStatus = myPrefs.getBool('notificationStatus') ?? true;

    // await navigatorkey.currentContext!.read<HomeController>().categoryListingApi(context, type: '1', title: '', isLoading: !isRefresh);
    // await navigatorkey.currentContext!.read<HomeController>().categoryListingApi(context, type: '2', title: '', isLoading: !isRefresh);

    // await navigatorkey.currentContext!.read<HomeController>().categoryListingApi(context, type: '4', title: '', isLoading: !isRefresh);

    // await navigatorkey.currentContext!.read<HomeController>().categoryListingApi(context, type: '3', title: '', isLoading: false);
  }

  getCMSData() async {
    generalWatch.getCMSApi(context, type: 'privacy-policy');
    generalWatch.getCMSApi(context, type: 'about-us');
    generalWatch.getFaqApi(context);
  }
}
