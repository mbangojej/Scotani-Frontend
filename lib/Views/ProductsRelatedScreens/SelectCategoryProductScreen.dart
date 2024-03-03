import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/InternetConnectivity.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Helpers/ProductRelatedHelper/SelectCategoryProductHelper.dart';
import 'package:skincanvas/main.dart';

class SelectCategoryScreen extends StatefulWidget {
  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  var themeColor = ThemeColors();
  var utils = AppUtils();
  var static = Statics();

  var homeRead = navigatorkey.currentContext!.read<HomeController>();
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  ScrollController scrollController = ScrollController();

  // testingFunc() async {
  //   await homeRead.selectConfigurableCategoriesInitialize(
  //       length: homeRead.configureDataList.length);
  //  // await apis();
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   testingFunc();
  // }

  @override
  Widget build(BuildContext context) {
    SelectCategoryHelper helper =
        SelectCategoryHelper(context, scrollController);

    return
        // RefreshIndicator(
        // backgroundColor: themeColor.orangeColor,
        // color: themeColor.blackColor,
        // onRefresh: () async {
        //   await apis();
        // },
        // child:
        WillPopScope(
      onWillPop: () async {
        if (generalWatch.restrictUserNavigation == false) {
          homeRead.updateIsShowGraphicsContainer(isBackButton: true);
          homeRead.categoryStatusUpdate(
              index: homeWatch.selectedcategorystatusindex);
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: themeColor.backGroundColor,
        body: InternetConnectivityScreen(
          widget: Container(
            width: static.width,
            height: static.height,
            child: Column(
              children: [
                utils.statusBar(context, color: themeColor.backGroundColor),
                helper.selectCategoryText(),

                helper.SelectionCategoryWidget(),
                Expanded(
                  child: helper.subCategoriesAndProducts(),
                ),

                // Expanded(child: helper.subCategoriesAndProducts()),

                SizedBox(
                  height: 10.h,
                ),
                helper.createProductButton(),
                utils.bottomBar(context, color: themeColor.backGroundColor),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }

  apis() {
    homeRead.categoryListingApi(context,
        type: '3', title: '', isLoading: false);
  }
}
