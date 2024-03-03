import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Views/SettingScreens/AboutUsScreen.dart';
import 'package:skincanvas/Views/SettingScreens/ChangePasswordScreen.dart';
import 'package:skincanvas/Views/SettingScreens/EditProfileScreen.dart';
import 'package:skincanvas/Views/SettingScreens/FAQScreen.dart';
import 'package:skincanvas/Views/SettingScreens/PrivacyAndPolicyScreen.dart';
import 'package:skincanvas/Views/SettingScreens/ReportAndErrorScreen.dart';
import 'package:skincanvas/main.dart';

class MoreFragmentHelper {
  BuildContext context;
  final setState;

  MoreFragmentHelper(this.context, this.setState);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  Widget settingText() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h) +
          EdgeInsets.only(top: 20.h),
      width: static.width,
      child: Container(
        width: static.width * .6,
        child: Text(
          'Settings',
          style: utils.generalHeadingBold(theme.whiteColor,
              size: static.width > 550 ? 20.sp : 26.sp,
              fontFamily: 'finalBold'),
        ),
      ),
    );
  }

  profileWidget() {
    return Consumer<GeneralController>(builder: (context, generalWatch, _) {
      return Container(
        width: static.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
            color: theme.lightBlackColor,
            borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    generalWatch.editNameController.text =
                        generalWatch.fullNameValue!;
                    generalWatch.editEmailController.text =
                        generalWatch.emailValue!;
                    generalWatch.editMobileController.text =
                        generalWatch.phoneValue!;
                    generalWatch.editAddressController.text =
                        generalWatch.addressValue!;
                    generalRead.selectedImageUpdation(
                        string: generalWatch.profilePhotoValue);

                    // Navigator.pushNamed(context, route.editProfileScreenRoute);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/Icons/edit.png',
                      height: static.width > 550 ? 16.h : 22.h,
                      width: static.width > 550 ? 16.w : 22.w,
                      color: theme.whiteColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                  ),
                  margin: EdgeInsets.only(top: 15.h),
                  decoration: BoxDecoration(
                      color: theme.whiteColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: theme.whiteColor, width: 3)),
                  child: Container(
                    width: static.width > 550
                        ? static.width * .20
                        : static.width * .28,
                    height: static.width > 550
                        ? static.width * .20
                        : static.width * .28,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.whiteColor,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: generalWatch.profilePhotoValue!,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              utils.loadingShimmer(
                        height: static.width > 550
                            ? static.width * .14
                            : static.width * .2,
                        width: static.width > 550
                            ? static.width * .14
                            : static.width * .2,
                      ),
                      errorWidget: (context, url, error) =>
                          utils.loadingShimmer(
                        height: static.width * .2,
                        width: static.width * .2,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '${generalWatch.fullNameValue}',
              style: utils.generalHeadingBold(theme.whiteColor,
                  size: static.width > 550 ? 16.h : 22.sp,
                  fontFamily: 'finalBold'),
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              '${generalWatch.emailValue}',
              style: utils.generalHeadingBold(theme.midGreyColor,
                  size: static.width > 550 ? 8.sp : 14.sp,
                  fontFamily: 'finalBold'),
            ),
            SizedBox(
              height: 8.h,
            ),
          ],
        ),
      );
    });
  }

  settingWidgets() {
    return Consumer<GeneralController>(builder: (context, generalWatch, _) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Column(
          children: [
            settingOptions(
                label: 'Change Password',
                image: 'changePassword',
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));

                  // await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PaypalPayment("25.0")))
                  //     .then((value) async {
                  //   if (value != null) {
                  //     MDPayPal paypal = value;
                  //     print("The paypal Token is:" + paypal.token.toString());
                  //     print("the paypal payer id is:" + paypal.payerID.toString());
                  //     print("The paypal id is: " + paypal.paymentId.toString());
                  //    // await userRead.confirmAppointmentApi(context,bookingID: data.id,payerID: paypal.payerID,paymentID: paypal.paymentId,paymentToken: paypal.token);
                  //   }
                  // });
                }),
            settingOptions(
                label: 'Notification',
                isSwitch: true,
                image: 'notification',
                onTap: () {}),
            generalWatch.privacyAndPolicyData != null
                ? settingOptions(
                    label: 'Privacy Policy',
                    image: 'privacy',
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivacyAndPolicyScreen()));
                    })
                : SizedBox(),
            generalWatch.aboutUsData != null
                ? settingOptions(
                    label: 'About Us',
                    image: 'about',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutUsScreen()));
                    })
                : SizedBox(),
            settingOptions(
                label: 'Report an Error',
                image: 'reportAndError',
                onTap: () {
                  generalWatch.reportNameController.text =
                      generalWatch.fullNameValue!;
                  generalWatch.reportEmailController.text =
                      generalWatch.emailValue!;
                  generalWatch.reportPhoneController.text =
                      generalWatch.phoneValue!;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportAndErrorScreen()));
                }),
            settingOptions(
                label: 'FAQs',
                image: 'faq',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FAQScreen()));
                }),
            settingOptions(
                label: 'Request Account Deletion',
                image: 'delete-account',
                isLogout: true,
                onTap: () {
                  AppUtils().exitingAppDialog(context,
                      headingTextColor: theme.blackColor,
                      dialogColor: theme.whiteColor,
                      icon: 'alertAnime',
                      heading: 'Alert',
                      message: "Are you sure you want to delete your account? This action is irreversible. Your account and all associated data, including profile information, order history, and contact details, will be permanently deleted after a specified time. Please note that this process cannot be undone.",
                      positiveButton: 'DELETE',
                      negativeButton: 'CANCEL', positiveAction: () {
                        authRead.deleteAccountApi(context);
                      }, negativeAction: () {
                        Navigator.pop(context);
                      });
                }),
            settingOptions(
                label: 'Logout',
                image: 'logout',
                isLogout: true,
                onTap: () {
                  // utils.genericDialog(context,
                  //     dialogColor: theme.lightBlackColor,
                  //     headingTextColor: theme.whiteColor,
                  //     heading: 'Log out of your account?',
                  //     negativeActionText: 'CANCEL',
                  //     positiveActionText: 'LOG OUT', negativeAction: () {
                  //   Navigator.pop(context);
                  // }, positiveAction: () {
                  //   authRead.logoutApi(context);
                  // });

                  AppUtils().exitingAppDialog(context,
                      headingTextColor: theme.blackColor,
                      dialogColor: theme.whiteColor,
                      icon: 'alertAnime',
                      heading: 'Alert',
                      message: "Are you sure you want to logout?",
                      positiveButton: 'LOG OUT',
                      negativeButton: 'CANCEL', positiveAction: () {
                    authRead.logoutApi(context);
                  }, negativeAction: () {
                    Navigator.pop(context);
                  });
                }),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      );
    });
  }

  settingOptions({label, isSwitch = false, onTap, image, isLogout = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: static.width,
        color: theme.lightBlackColor,
        margin: EdgeInsets.symmetric(vertical: 3.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Image.asset('assets/Icons/$image.png',
                width: 20.h, height: 18.h, color: theme.whiteColor),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
                child: Text(
              label,
              style: utils.xHeadingStyle(theme.whiteColor,
                  fontFamily: "finalBold"),
            )),
            SizedBox(
              width: 10.w,
            ),
            // Consumer<GeneralController>(builder: (context, watch, _) {
            //   return
                isSwitch
                  ? Container(
                      child: FlutterSwitch(
                        width: static.width > 550 ? 32.w : 45.0.w,
                        height: static.width > 550 ? 16.h : 20.0.h,
                        toggleSize: static.width > 550 ? 14.w : 18.0.w,
                        value: generalWatch.notificationStatus,
                        borderRadius: 30.0.r,
                        padding: 2.0,
                        inactiveColor: theme.greyColor,
                        activeColor: theme.orangeColor,
                        onToggle: (val) async {
                          // homeRead.screenIndexUpdate(index: 0);
                          generalRead.getNotificationStatusApi(context,
                              status: generalWatch.notificationStatus);

                          print('The status is:' + val.toString());
                        },
                      ),
                    )
                  : isLogout
                      ? SizedBox()
                      : Icon(
                          Icons.chevron_right_sharp,
                          size: static.width > 550 ? 18.w : 24.w,
                          color: theme.whiteColor,
                        ),
            // }),
          ],
        ),
      ),
    );
  }
}
