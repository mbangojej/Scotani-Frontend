import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Models/MDCMSModal.dart';
import 'package:skincanvas/Models/MDChangeNotificationStatus.dart';
import 'package:skincanvas/Models/MDErrorModal.dart';
import 'package:skincanvas/Models/MDFAQModal.dart';
import 'package:skincanvas/Models/MDNotificationListModal.dart';
import 'package:skincanvas/Models/MDOnBoadingContentModel.dart';
import 'package:skincanvas/Models/MDSettingModals.dart';
import 'package:skincanvas/Models/MDUserModal.dart';
import 'package:skincanvas/Services/GeneralServices.dart';
import 'package:skincanvas/main.dart';

class GeneralController with ChangeNotifier {
  MDErrorModal mdErrorModal = MDErrorModal();
  MDCMSModal mdcmsModal = MDCMSModal();
  MDUserModal mdUserModal = MDUserModal();
  MDFAQModal mdfaqModal = MDFAQModal();
  MDNotificationListModal mdNotificationListModal = MDNotificationListModal();
  MDChangeNotificationStatusModal mdChangeNotificationStatusModal =
      MDChangeNotificationStatusModal();

  MDonBoardingModal mdOnBoardingModal = MDonBoardingModal();
  MDSettingModal mdSettingModal = MDSettingModal();

  List<MDFAQCategories> faqList = [];
  List<Notifications> notificationList = [];
  int notificationPage = 1;

  var utils = AppUtils();
  var themeColor = ThemeColors();
  var static = Statics();
  var routes = Routes();

  TextEditingController reportNameController = TextEditingController();
  TextEditingController reportEmailController = TextEditingController();
  TextEditingController reportPhoneController = TextEditingController();
  TextEditingController reportSubjectController = TextEditingController();
  TextEditingController reportMessageController = TextEditingController();

  String? userTokenValue;
  String? userIDValue;
  String? emailValue;
  String? phoneValue;
  String? fullNameValue;
  String? addressValue;
  int isEmailVerified = 0;
  String? profilePhotoValue;
  bool notificationStatus = true;

  fetchingUserStaticData() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    emailValue = myPrefs.getString(static.email) ?? '';
    userTokenValue = myPrefs.getString(static.userToken) ?? '';
    userIDValue = myPrefs.getString(static.userID) ?? '';
    phoneValue = myPrefs.getString(static.phone) ?? '';
    addressValue = myPrefs.getString(static.address) ?? '';
    fullNameValue = myPrefs.getString(static.fullName) ?? '';
    profilePhotoValue = myPrefs.getString(static.profilePhoto) ?? '';
    isEmailVerified = myPrefs.getInt(static.isVerified) ?? 0;
    notificationStatus =
        myPrefs.getBool(static.notificationStatusString) ?? true;

    print("Getting email Value:" + emailValue!);
    print("Getting userTokenValue Value:" + userTokenValue!);
    print("Getting userIDValue Value:" + userIDValue!);
    print("Getting phoneValue Value:" + phoneValue!);
    print("Getting addressValue Value:" + addressValue!);
    print("Getting fullNameValue Value:" + fullNameValue!);
    print("Getting profilePhotoValue Value:" + profilePhotoValue!);
    print("Getting Email Verified Value:" + isEmailVerified.toString());

    notifyListeners();
  }

  //.................... Restrict User From Navigating while Api Call ....................//

  bool restrictUserNavigation = false;

  updateRestrictUserNavigation({value = false}) {
    restrictUserNavigation = value;

    print("Cart From ${restrictUserNavigation}");
    notifyListeners();
  }

  //.................. On Boarding ..................//
  int currentPage = 0;

  onBoardingPageUpdate({index}) {
    currentPage = index;
    notifyListeners();
  }

  //................... Notification Fragment .........//

  bool isLoadingNotification = false;

  updateIsLoadingNotification({value}) {
    isLoadingNotification = value;

    print("Update Func");
    notifyListeners();
  }

  //.................... Notification .................//

  notificationUpdate({status}) {
    notificationStatus = status;
    notifyListeners();
  }

  //................... FAQ ....................//

  TextEditingController faqController = TextEditingController();

  //...................... Change Password ................//

  TextEditingController changeOldController = TextEditingController();
  TextEditingController changeNewController = TextEditingController();
  TextEditingController changeConfirmController = TextEditingController();

  bool isChangeOldVisible = true;
  bool isChangeNewVisible = true;
  bool isChangeConfirmVisible = true;

  changeOldVisbileUpdator(bool value) {
    isChangeOldVisible = value;
    notifyListeners();
  }

  changeNewVisbileUpdator(bool value) {
    isChangeNewVisible = value;
    notifyListeners();
  }

  changeConfirmVisbileUpdator(bool value) {
    isChangeConfirmVisible = value;
    notifyListeners();
  }

  //............... CMS Data ..................//

  var privacyAndPolicyData;
  var aboutUsData;

  //.................. Edit Profile ...............//

  TextEditingController editEmailController = TextEditingController();
  TextEditingController editNameController = TextEditingController();
  TextEditingController editMobileController = TextEditingController();
  TextEditingController editAddressController = TextEditingController();

  String? selectedImageByString;
  bool isEditProfileImage = true;

  editProfileImageUpdate({value = false}) {
    isEditProfileImage = value;
    notifyListeners();
  }

  selectedImageUpdation({string}) {
    selectedImageByString = string;

    print('The image is:' + selectedImageByString.toString());

    notifyListeners();
  }

  //......................... Apis.......................//

  onBoardingApi(context) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = GeneralApisServices();

    var response = await apis.onBoard();
    print('The onBoard Api  response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdOnBoardingModal = MDonBoardingModal.fromJson(response);
        apiResponse = mdOnBoardingModal.status!;

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to update');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to update');
      return false;
    }
  }

  // uploadImageApi(context, {file}) async {
  //   SharedPreferences myPrefs = await SharedPreferences.getInstance();
  //
  //   var apis = GeneralApisServices();
  //
  //
  //   EasyLoading.show(status: "Uploading Image",maskType: EasyLoadingMaskType.black);
  //
  //   FormData formData = FormData.fromMap({
  //     'image': await MultipartFile.fromFile(
  //       file!.path,
  //       filename: 'image.jpg', // Replace with the desired filename on the server
  //     ),
  //   });
  //
  //   var response = await apis.uploadingImage(formData);
  //
  //   if (response != null) {
  //     if (response['status']==1) {
  //
  //       String apiData = response['imageURL'];
  //       selectedImageUpdation(string: apiData);
  //
  //       myPrefs.setString(static.profilePhoto, apiData);
  //       await fetchingUserStaticData();
  //
  //       utils.apiResponseToast(message: 'Image Uploaded Successfully');
  //       notifyListeners();
  //       return true;
  //     } else {
  //
  //       mdErrorModal=MDErrorModal.fromJson(response);
  //       utils.apiResponseToast(message:'Failed to Get Response');
  //     }
  //   }
  //
  //   else {
  //     mdErrorModal=MDErrorModal.fromJson(response);
  //     utils.apiResponseToast(message:'Failed to Get Response');
  //     return false;
  //   }
  // }

  getCMSApi(context, {type = 'privacy-policy'}) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = GeneralApisServices();

    final Map<String, dynamic> data = {
      "slug": "$type",
    };

    print(data.toString());

    var response = await apis.getCMS(data: data);
    // print('The Get CMS of response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdcmsModal = MDCMSModal.fromJson(response);

        if (type == 'privacy-policy') {
          privacyAndPolicyData =
              utils.convertHtmlToPlainText(mdcmsModal.content!.description!);
          print("privacyAndPolicyData ${privacyAndPolicyData}");
        } else {
          aboutUsData =
              utils.convertHtmlToPlainText(mdcmsModal.content!.description!);
          print("aboutUsData ${aboutUsData}");
          getSettingApi(context);
        }

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);

        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);
      return false;
    }
  }

  Future<bool> getFaqApi(context, {searchKey = '', isLoading = false}) async {
    print("The legnth of the empty is List is:" + faqList.length.toString());

    FocusScope.of(context).unfocus();

    var apis = GeneralApisServices();

    final Map<String, dynamic> data = {
      "searchQuery": "$searchKey",
    };

    if (isLoading) {
      EasyLoading.show(status: "loading", maskType: EasyLoadingMaskType.black);
    }

    var response = await apis.faq(data: data);
    print('The Get FAQ Response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdfaqModal = MDFAQModal.fromJson(response);
        faqList.clear();
        faqList.addAll(mdfaqModal.data!.categories!.toList());

        print("The legnth of the List is:" + faqList.length.toString());
        if (isLoading) {
          EasyLoading.dismiss();
        }

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      return false;
    }
    return false;
  }

  editProfileApi(context, {image}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    FocusManager.instance.primaryFocus?.unfocus();

    var apis = GeneralApisServices();

    updateRestrictUserNavigation(value: true);

    EasyLoading.show(status: "Updating User data", maskType: EasyLoadingMaskType.black);

    final Map<String, dynamic> data = {
      "fullName": "${editNameController.text}",
      "mobile": "${editMobileController.text}",
      "address": "${editAddressController.text}",
      "profileImage": "$image",
    };

    print(data.toString());

    var response = await apis.editProfile(
      data: data,
    );
    print('The Edit profile of response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        //  mdUserModal = MDUserModal.fromJson(response);
        utils.apiResponseToast(message: 'Updated Successfully');

        await navigatorkey.currentContext!
            .read<GeneralController>()
            .getProfileApi(context);

        // myPrefs.setString(static.phone, editMobileController.text);
        // myPrefs.setString(static.fullName, editNameController.text);
        // myPrefs.setString(static.address, editAddressController.text);
        // myPrefs.setString(static.profilePhoto,
        //     'https://skin-canvas.arhamsoft.org//images/$image');
        await editProfileImageUpdate(value: false);
        updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to update');
        updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to update');
      updateRestrictUserNavigation();
      return false;
    }
  }

  Future<bool> getNotificationListApi(context,
      {isLoading = false, page = 1}) async {
    var apis = GeneralApisServices();

    updateIsLoadingNotification(value: false);

    if (page == 1) {
      notificationList.clear();
      notificationPage = 1;
    }

    updateRestrictUserNavigation(value: true);

    if (isLoading) {
      EasyLoading.show(
          status: "Getting Notifications List",
          maskType: EasyLoadingMaskType.black);
    }

    final Map<String, dynamic> data = {
      "page": page,
    };

    print("Data is" + data.toString());

    var response = await apis.notificationListing(data);
    print('The Get notification List Response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdNotificationListModal = MDNotificationListModal.fromJson(response);
        notificationList
            .addAll(mdNotificationListModal.data!.notifications!.toList());

        if (mdNotificationListModal.data!.pagination!.pages!.toInt() >= page) {
          notificationPage = notificationPage + 1;
        }

        print(
            "The legnth of the List is:" + notificationList.length.toString());

        if (notificationList.length == 0)
          updateIsLoadingNotification(value: true);

        if (isLoading) {
          EasyLoading.dismiss();
        }
        updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        updateIsLoadingNotification(value: true);
        utils.apiResponseToast(message: 'Failed to Get Response');
        updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      updateIsLoadingNotification(value: true);
      utils.apiResponseToast(message: 'Failed to Get Response');
      updateRestrictUserNavigation();

      return false;
    }
    return false;
  }

  Future<bool> getNotificationStatusApi(context, {status = false}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = GeneralApisServices();

    updateRestrictUserNavigation(value: true);
    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);

    var response = await apis.notificationStatus();
    print('The Get notification status Api Response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdChangeNotificationStatusModal =
            MDChangeNotificationStatusModal.fromJson(response);

        notificationUpdate(
            status: mdChangeNotificationStatusModal.data!.status == 1
                ? true
                : false);

        myPrefs.setBool(static.notificationStatusString,
            mdChangeNotificationStatusModal.data!.status == 1 ? true : false);

        notificationStatus =
            myPrefs.getBool(static.notificationStatusString) ?? true;

        print("Notification Value ${notificationStatus}");

        EasyLoading.showToast("Status Updated Successfully",
            toastPosition: EasyLoadingToastPosition.bottom);

        updateRestrictUserNavigation();

        // if (!status)
        //   EasyLoading.showSuccess("Notification Enabled Successfully");
        // else
        //   EasyLoading.showSuccess("Notification Disabled Successfully");

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
        updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      updateRestrictUserNavigation();
      return false;
    }
    return false;
  }

  Future<bool> changeNotificationStatusApi(context, {id}) async {
    var apis = GeneralApisServices();

    updateRestrictUserNavigation(value: true);

    EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black);

    final Map<String, dynamic> data = {
      "notificationId": "${id}",
    };

    print(data.toString());

    var response = await apis.changeNotificationStatus(data);
    print('The change notification status Api Response is:' +
        response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        for (var obj in notificationList) {
          if (obj.sId == id) {
            obj.status = true;
            break; // Break the loop since we found a match
          }
        }

        EasyLoading.dismiss();

        updateRestrictUserNavigation();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
        updateRestrictUserNavigation();
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      updateRestrictUserNavigation();
      return false;
    }
    return false;
  }

  reportAndErrorApi(context) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    FocusManager.instance.primaryFocus?.unfocus();
    var apis = GeneralApisServices();

    EasyLoading.show(
        status: "Sending Error Report", maskType: EasyLoadingMaskType.black);

    final Map<String, dynamic> data = {
      "name": "${reportNameController.text}",
      "email": "${reportEmailController.text}",
      "phone": "${reportPhoneController.text}",
      "subject": "${reportSubjectController.text}",
      "message": "${reportMessageController.text}"
    };

    print(data.toString());

    var response = await apis.errorAndReport(
      data: data,
    );
    print('The Error And Report response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        utils.apiResponseToast(message: 'Your message sent successfully');

        reportSubjectController.clear();
        reportMessageController.clear();
        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Sent Message');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Sent Message');
      return false;
    }
  }

  uploadImageApi(context, {file, isSignup = true}) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = GeneralApisServices();

    EasyLoading.show(
        status: "Uploading Image", maskType: EasyLoadingMaskType.black);

    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        file!.path,
        filename:
            'image.jpg', // Replace with the desired filename on the server
      ),
    });

    var response = await apis.uploadingImage(formData);

    if (response != null) {
      if (response['status'] == 1) {
        String apiData = response['imageURL'];
        selectedImageUpdation(string: apiData);

        myPrefs.setString(static.profilePhoto, apiData);

        if (isSignup) {
          await fetchingUserStaticData();
        }
        utils.apiResponseToast(message: 'Image Uploaded Successfully');

        editProfileImageUpdate(value: true);

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to Get Response');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to Get Response');
      return false;
    }
  }

  getSettingApi(context) async {
    apiResponse = 0;
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    var apis = GeneralApisServices();

    var response = await apis.getSetting();
    print('The onBoard Api  response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdSettingModal = MDSettingModal.fromJson(response);

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        utils.apiResponseToast(message: 'Failed to update');
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      utils.apiResponseToast(message: 'Failed to update');
      return false;
    }
  }

  getProfileApi(context) async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    var apis = GeneralApisServices();

    // EasyLoading.show(status: 'Verifying your credentials');

    var response = await apis.getProfile();
    print('The get profile api response is:' + response.toString());

    if (response != null) {
      if (response['status'] == 1) {
        mdUserModal = MDUserModal.fromJson(response);

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

        fetchingUserStaticData();

        notifyListeners();
        return true;
      } else {
        mdErrorModal = MDErrorModal.fromJson(response);
        EasyLoading.showToast('${mdErrorModal.message}',
            dismissOnTap: true,
            duration: Duration(seconds: 1),
            toastPosition: EasyLoadingToastPosition.bottom);
      }
    } else {
      mdErrorModal = MDErrorModal.fromJson(response);
      EasyLoading.showToast('${mdErrorModal.message}',
          dismissOnTap: true,
          duration: Duration(seconds: 1),
          toastPosition: EasyLoadingToastPosition.bottom);

      return false;
    }
  }
}
