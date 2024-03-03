import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Models/MDErrorModal.dart';
import 'package:skincanvas/Models/MDUserModal.dart';
import 'package:skincanvas/Services/AuthenticationServices.dart';
import 'package:skincanvas/main.dart';

import 'OrdersAndCheckOutAndWishlistProvider.dart';

class AuthenticationController with ChangeNotifier {
  //................... Modals Objects ...................//

  var generalWatch = Provider.of<GeneralController>(
      navigatorkey.currentContext!,
      listen: false);

  MDUserModal mdUserModal = MDUserModal();
  MDErrorModal mdErrorModal = MDErrorModal();

  var utils = AppUtils();
  var themeColor = ThemeColors();
  var static = Statics();
  var routes = Routes();

  //..................... Firebase Logout ................//

  updateIsLogout() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    // myPrefs.clear();

    await myPrefs.remove(static.userToken);
    await myPrefs.remove(static.userID);
    await myPrefs.remove(static.phone);
    await myPrefs.remove(static.email);
    await myPrefs.remove(static.fullName);
    await myPrefs.remove(static.address);
    await myPrefs.remove(static.profilePhoto);
    await myPrefs.remove(static.isVerified);
    await myPrefs.remove(static.notificationStatusString);
    await myPrefs.remove(static.isRememberEmail);
    await myPrefs.remove(static.isRememberPassword);
    await myPrefs.remove(static.isRememberStatus);

    Navigator.pushNamed(
        navigatorkey.currentContext!, routes.loginAndSignUpRoute);

    notifyListeners();
  }

  //....................... Login Screen .................//
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool isLoginPassVisible = true;
  bool isRemember = false;

  loginPasswordUpdator(bool value) {
    isLoginPassVisible = value;
    notifyListeners();
  }

  rememberMeUpdator({value = false, email = '', password = ''}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    isRemember = value!;
    loginEmailController.text = email;
    loginPasswordController.text = password;

    fcmTokenValue = myPrefs.getString(static.fcmToken);
    navigatorkey.currentContext!
        .read<GeneralController>()
        .fetchingUserStaticData();

    if (value) {
      myPrefs.setBool(static.isRememberStatus, value);
      myPrefs.setString(static.isRememberEmail, email);
      myPrefs.setString(static.isRememberPassword, password);
    }

    notifyListeners();
  }

  //.................. Forget Password ...........//

  TextEditingController forgetPasswordController = TextEditingController();

  //.................. Signup ..................//

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupMobileController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupAddressController = TextEditingController();

  File? selectedImageByFile;

  bool isSignupPassVisible = true;

  signupPasswordUpdator(bool value) {
    isSignupPassVisible = value;
    notifyListeners();
  }

  selectedImageUpdation({file}) {
    selectedImageByFile = file;

    print('The image is:' + file.toString());
    notifyListeners();
  }

  //.............. Reset Password ...............//

  TextEditingController resetNewPController = TextEditingController();
  TextEditingController resetConfirmController = TextEditingController();

  bool resetNewPassVisible = true;
  bool resetConfirmPassVisible = true;

  resetPasswordUpdator({newPass = true, confirmPass = true}) {
    resetNewPassVisible = newPass;
    resetConfirmPassVisible = confirmPass;
    notifyListeners();
  }

  //............... Verification Screen .............//

  TextEditingController emailVerificationController = TextEditingController();

  bool forgetPasswordNavToVerified = false;

  verificationEmailcontrolllerInitializer(otpValue) {
    emailVerificationController.text = otpValue;
    notifyListeners();
  }

  forgetPasswordNavToVerifiedUpdator({bool value = false}) {
    forgetPasswordNavToVerified = value;
    notifyListeners();
  }

  //................... Apis...................//

  signupApi(context, {image}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    FocusManager.instance.primaryFocus?.unfocus();

    fcmTokenValue = myPrefs.getString(static.fcmToken);

    var apis = AuthenticationApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Processing');

    var data = {
      'fullName': '${signupNameController.text}',
      'email': '${signupEmailController.text}',
      'phone': '${signupMobileController.text}',
      'password': '${signupPasswordController.text}',
      'address': '${signupAddressController.text}',
      'profileImage': '${image}',
      'fcmToken': '$fcmTokenValue',
    };

    print("The initialize data is:::" + data.toString());

    var response = await apis.signup(data: data);
    print('The Register response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdUserModal = MDUserModal.fromJson(response);

        myPrefs.setString(
            static.userToken, mdUserModal.data!.accessToken.toString());
        myPrefs.setString(static.userID, mdUserModal.data!.userId.toString());
        myPrefs.setString(static.phone, mdUserModal.data!.phone.toString());
        myPrefs.setString(static.email, mdUserModal.data!.email.toString());
        myPrefs.setString(
            static.fullName, mdUserModal.data!.fullName.toString());
        myPrefs.setString(static.address, mdUserModal.data!.address.toString());
        myPrefs.setString(
            static.profilePhoto, mdUserModal.data!.userImage!.toString());
        myPrefs.setInt(static.isVerified, mdUserModal.data!.emailVerified!);
        myPrefs.setBool(static.notificationStatusString,
            mdUserModal.data!.sendNotification == 1 ? true : false);

        navigatorkey.currentContext!
            .read<GeneralController>()
            .fetchingUserStaticData();

        EasyLoading.showSuccess('Successfully Register');

        signupNameController.clear();
        signupEmailController.clear();
        signupMobileController.clear();
        signupPasswordController.clear();
        signupAddressController.clear();
        selectedImageByFile = null;

        forgetPasswordNavToVerifiedUpdator(value: false);

        generalWatch.updateRestrictUserNavigation();
        Navigator.pushNamed(context, routes.emailVerificationScreenRoute);
        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);

        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);

        generalWatch.updateRestrictUserNavigation();

        // utils.showToast(context, text: 'failed_to_register'.tr());
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);

      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  signInApi(context) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    fcmTokenValue = myPrefs.getString(static.fcmToken);
    FocusManager.instance.primaryFocus?.unfocus();

    var apis = AuthenticationApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Verifying your credentials');

    var data = {
      "email": "${loginEmailController.text}",
      "password": "${loginPasswordController.text}",
      "fcmToken": "$fcmTokenValue"
    };

    print(data.toString());

    var response = await apis.login(data: data);
    print('The login response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdUserModal = MDUserModal.fromJson(response);

        myPrefs.setString(
            static.userToken, mdUserModal.data!.accessToken.toString());
        myPrefs.setString(static.userID, mdUserModal.data!.userId.toString());
        myPrefs.setString(static.phone, mdUserModal.data!.phone.toString());
        myPrefs.setString(static.email, mdUserModal.data!.email.toString());
        myPrefs.setString(
            static.fullName, mdUserModal.data!.fullName.toString());
        myPrefs.setString(static.address, mdUserModal.data!.address.toString());
        myPrefs.setString(
            static.profilePhoto, mdUserModal.data!.userImage!.toString());
        myPrefs.setInt(static.isVerified, mdUserModal.data!.emailVerified!);
        myPrefs.setBool(static.notificationStatusString,
            mdUserModal.data!.sendNotification == 1 ? true : false);

        await Provider.of<GeneralController>(context, listen: false)
            .fetchingUserStaticData();

        if (mdUserModal.data!.emailVerified == 0) {
          forgetPasswordNavToVerifiedUpdator(value: false);
          Navigator.pushNamed(context, routes.emailVerificationScreenRoute);
          EasyLoading.showToast('Please Verify your account.',
              dismissOnTap: true,
              duration: Duration(seconds: 3),
              toastPosition: EasyLoadingToastPosition.bottom);
        } else {
          EasyLoading.showToast('${mdUserModal.message}',
              dismissOnTap: true,
              duration: Duration(seconds: 1),
              toastPosition: EasyLoadingToastPosition.bottom);
          navigatorkey.currentContext!
              .read<HomeController>()
              .screenIndexUpdate(index: 0);
          Navigator.pushNamed(context, routes.bottomNavigationScreenRoute);
        }

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  forgetPasswordApi(context, {email}) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    FocusManager.instance.primaryFocus?.unfocus();

    // String? FcmToken = myPrefs.getString(static.fcmToken);

    var apis = AuthenticationApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Checking Email');

    var data = {
      "email": email,
    };

    print(data.toString());

    var response = await apis.forgetPassword(data: data);
    print('The ForgetPassword Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdErrorModal = MDErrorModal.fromJson(response);
        // EasyLoading.showToast('${mdErrorModal.message}',dismissOnTap: true,duration: Duration(seconds: 3),toastPosition: EasyLoadingToastPosition.bottom);

        EasyLoading.showToast('OTP Sent Successfully',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);

        await forgetPasswordNavToVerifiedUpdator(value: true);

        generalWatch.emailValue = email;
        generalWatch.userIDValue = mdErrorModal.data!.userId.toString();

        apiResponse = mdErrorModal.status!;
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  verifyingOTPApi(context, {type = 1, OTP, userID}) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    FocusManager.instance.primaryFocus?.unfocus();

    var apis = AuthenticationApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Verifying OTP');

    var data = {"userId": "$userID", "otp": "$OTP", "type": type};

    print(data.toString());

    var response = await apis.verifyingOTP(data: data);
    print('The verifying Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);

        apiResponse = mdErrorModal.status!;

        if (!forgetPasswordNavToVerified && type == 1) {
          navigatorkey.currentContext!
              .read<HomeController>()
              .screenIndexUpdate(index: 0);
          generalWatch.updateRestrictUserNavigation();
          Navigator.pushNamed(context, routes.bottomNavigationScreenRoute);
          myPrefs.setInt(static.isVerified, 1);
        } else {
          generalWatch.updateRestrictUserNavigation();

          Navigator.pushNamed(context, routes.loginScreenRoute);
        }

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  resendOTPApi(context, {userID}) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = AuthenticationApisServices();
    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Resending OTP');

    var data = {
      "userId": "$userID",
    };

    print(data.toString());

    var response = await apis.resendOTP(data: data);
    print('The resending OTP Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  resetPasswordApi(context, {email, newPassword = '', oldPassword = ''}) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    FocusManager.instance.primaryFocus?.unfocus();

    var apis = AuthenticationApisServices();

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Changing Password');

    Map<String, dynamic> data = Map();

    data['email'] = "${email}";
    data['newPassword'] = "${newPassword}";
    data['oldPassword'] = "${oldPassword}";

    print(data.toString());

    var response = await apis.changingPassword(data: data);
    print('The Changing Password  Api response is:' + response.toString());

    if (response != null) {
      if (response['success'] == true) {
        EasyLoading.showToast('Password Changed Successfully',
            dismissOnTap: true,
            duration: Duration(seconds: 3),
            toastPosition: EasyLoadingToastPosition.bottom);

        generalWatch.updateRestrictUserNavigation();

        generalWatch.changeNewController.clear();
        generalWatch.changeConfirmController.clear();
        generalWatch.changeOldController.clear();
        forgetPasswordController.clear();
        resetNewPController.clear();
        resetConfirmController.clear();

        // Navigator.pushNamed(context, Routes().loginScreenRoute);

        mdErrorModal = MDErrorModal.fromJson(response);

        apiResponse = mdErrorModal.status!;
        generalWatch.updateRestrictUserNavigation();

        apiResponse = 1;

        print("api REspinse ${apiResponse}");

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
        generalWatch.updateRestrictUserNavigation();

        return false;
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      generalWatch.updateRestrictUserNavigation();

      return false;
    }
  }

  deleteAccountApi(context) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = AuthenticationApisServices();
    Navigator.pop(context);

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Deleting Your Account');

    Map<String, dynamic> data = Map();
    data['userId'] = "${generalWatch.userIDValue}";

    print(data.toString());

    var response = await apis.deleteAccount(data: data);
    print('The Delete Account Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        updateIsLogout();

        navigatorkey.currentContext!
            .read<OrderCheckOutWishlistController>()
            .quantityOfCartProduct = 0;

        generalWatch.fetchingUserStaticData();

        Navigator.pushNamedAndRemoveUntil(
            context, routes.loginAndSignUpRoute, (route) => false);

        utils.apiResponseToast(message: response['message']);

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        utils.apiResponseToast(message: 'Failed to Logout');
        mdErrorModal = MDErrorModal.fromJson(response);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      utils.apiResponseToast(message: 'Failed to Logout');
      mdErrorModal = MDErrorModal.fromJson(response);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }

  logoutApi(context) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = AuthenticationApisServices();
    Navigator.pop(context);

    generalWatch.updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: 'Logging Out');

    Map<String, dynamic> data = Map();
    data['userId'] = "${generalWatch.userIDValue}";

    print(data.toString());

    var response = await apis.logout(data: data);
    print('The Logout  Api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        await myPrefs.remove(static.userToken);
        await myPrefs.remove(static.userID);
        await myPrefs.remove(static.fullName);
        await myPrefs.remove(static.address);
        await myPrefs.remove(static.profilePhoto);
        await myPrefs.remove(static.isVerified);
        await myPrefs.remove(static.notificationStatusString);

        navigatorkey.currentContext!
            .read<OrderCheckOutWishlistController>()
            .quantityOfCartProduct = 0;

        generalWatch.fetchingUserStaticData();

        Navigator.pushNamedAndRemoveUntil(
            context, routes.loginAndSignUpRoute, (route) => false);
        utils.apiResponseToast(message: 'Logout Successfully');

        generalWatch.updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        utils.apiResponseToast(message: 'Failed to Logout');
        mdErrorModal = MDErrorModal.fromJson(response);
        generalWatch.updateRestrictUserNavigation();
        return false;
      }
    } else {
      utils.apiResponseToast(message: 'Failed to Logout');
      mdErrorModal = MDErrorModal.fromJson(response);
      generalWatch.updateRestrictUserNavigation();
      return false;
    }
  }
}
