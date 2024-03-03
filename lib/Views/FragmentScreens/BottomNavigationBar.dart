import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/SelectTattooAndProductBottomSheet.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/Views/FragmentScreens/HomeFragment.dart';
import 'package:skincanvas/Views/FragmentScreens/MoreFragment.dart';
import 'package:skincanvas/Views/FragmentScreens/NotificationsFragment.dart';
import 'package:skincanvas/Views/FragmentScreens/OrdersFragment.dart';
import 'package:skincanvas/main.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final List<Widget> _screens = [
    HomeFragmentScreen(),
    OrdersFragmentScreen(),
    NotificationsFragmentScreen(),
    MoreFragmentScreen(),
  ];

  var utils = AppUtils();
  var theme = ThemeColors();
  var route = Routes();
  var static = Statics();

  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: theme.backGroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          width: 70.w,
          height: 70.w,
          padding: EdgeInsets.all(4),
          child: InkWell(
            onTap: () async {
              homeRead.categorySelectionToCreate(product: false, tattoo: false);

              homeRead.designPromptController.text = '';
              homeRead.desireTextController.text = '';
              homeRead.desireColorController.text = '';

              await homeRead.createTattooBodySelectionInitialize();
              await homeRead.createTattooDesignSelectionInitialize();
              await homeRead.selectGraphicsStatusInitialize();

              await homeRead.updateIsShowGraphicsContainer(isBackButton: true);

              Navigator.pop(context);

              Navigator.pushNamed(context, route.createTattooScreenRoute);

              homeRead.updateImageColorSliderPosition(position: 0.0);

              homeRead.updateImageShadeSliderPosition(position: 0.0);

              // homeRead
              //     .updateImageCurrentColor(
              //         color: themeColor
              //             .whiteColor);

              await homeRead.updateBaseColorIniatlize(Color(0xffffffff));

              homeRead.updateImageSize(size: 30.0);
              homeRead.updateTextSize(size: 10.0);

              // SelectTattooAndProductBottomSheet().sheet(context);
            },
            child: Image.asset('assets/Images/centerLogo1.png',
                width: static.width > 550 ? 18.w : 24.w,
                height: static.width > 550 ? 18.h : 24.h),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 4.0,
          color: theme.lightBlackColor,
          child: Container(
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomNavItem(
                  imageAsset: 'assets/Icons/home.png',
                  text: 'Home',
                  index: 0,
                  onTap: () {
                    homeRead.screenIndexUpdate(index: 0);
                  },
                ),
                buildBottomNavItem(
                    imageAsset: 'assets/Icons/order.png',
                    text: 'Orders',
                    index: 1,
                    onTap: () {
                      homeRead.screenIndexUpdate(index: 1);
                      navigatorkey.currentContext!
                          .read<OrderCheckOutWishlistController>()
                          .orderListingApi(context,
                              isLoading: true, searching: '');
                    }),
                SizedBox(width: 50.w), // This creates space for the FAB
                buildBottomNavItem(
                  imageAsset: 'assets/Icons/bell.png',
                  text: 'Notification',
                  index: 2,
                  onTap: () {
                    homeRead.screenIndexUpdate(index: 2);

                    navigatorkey.currentContext!
                        .read<GeneralController>()
                        .getNotificationListApi(context, isLoading: true);
                  },
                ),
                buildBottomNavItem(
                  imageAsset: 'assets/Icons/ellipse.png',
                  text: 'More',
                  index: 3,
                  onTap: () {
                    homeRead.screenIndexUpdate(index: 3);
                    navigatorkey.currentContext!
                        .read<GeneralController>()
                        .getProfileApi(context);
                  },
                ),
              ],
            ),
          ),
        ),
        body: _screens[homeWatch.screenIndex],
      ),
    );
  }

  Widget buildBottomNavItem({imageAsset, text, index, onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        // margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageAsset,
              width: 18.w,
              height: 18.h,
              color: homeWatch.screenIndex == index
                  ? theme.whiteColor
                  : theme.midGreyColor.withOpacity(.6),
            ),
            SizedBox(height: 4.h), // Some spacing between image and text
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style: utils.smallLabelStyle(
                    homeWatch.screenIndex == index
                        ? theme.whiteColor
                        : theme.greyColor,
                    fontFamily: homeWatch.screenIndex == index
                        ? 'finalBold'
                        : 'finalBook',
                  ),
                  maxLines: 1, // Set maxLines to 1 to ensure single line
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
