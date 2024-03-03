import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/entities.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/main.dart';

class EditProfileHelper {
  BuildContext context;

  EditProfileHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  XFile? selectedImage;
  var croppedFile;
  var selectedFile;

  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();

  Widget editProfileText() {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      width: static.width,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'Edit Profile',
                style: utils.generalHeadingBold(theme.whiteColor,
                    size: static.width > 550 ? 20.sp : 26.sp,
                    fontFamily: 'finalBold'),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(CupertinoIcons.back),
                  color: theme.whiteColor,
                  onPressed: () {
                    Navigator.pop(context);
                  }, // Callback function when pressed
                  tooltip: 'Like', // Optional tooltip text
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  cameraWidget() {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            decoration: BoxDecoration(
                color: theme.backGroundColor,
                shape: BoxShape.circle,
                border: Border.all(color: theme.orangeColor)),
            child: Container(
              width: static.width > 500 ? 100.w : 115.w,
              height: static.width > 500 ? 100.h : 115.h,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.lightGreyColor,
              ),
              child: /*generalWatch.selectedImageByString !=null ?
            Image.file( File('${generalWatch.selectedImageByString}'), fit: BoxFit.cover):  */

                  ///data/user/0/com.arhamsoft.skincanvas/cache/image_cropper_1690978076625.jpg
                  CachedNetworkImage(
                imageUrl: generalWatch.isEditProfileImage
                    ? generalWatch.selectedImageByString.toString()
                    : generalWatch.profilePhotoValue!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    utils.loadingShimmer(
                  width: 100.w,
                  height: 100.h,
                ),
                errorWidget: (context, url, error) => utils.loadingShimmer(
                  width: 100.w,
                  height: 100.h,
                ),
                fit: BoxFit.contain,
              ),
            )),
        Positioned(
            bottom:MediaQuery.of(navigatorkey.currentContext!).size.width > 550 ? 10.h : 20.h,
            right:MediaQuery.of(navigatorkey.currentContext!).size.width > 550 ? 8.w : 0.h,
            child: GestureDetector(
              onTap: () {
                utils.imageSelectionDialogBox(
                  context,
                  onTapCamera: () async {
                    Navigator.pop(context);
                    await selectImage(
                      ImageSource.camera,
                    );
                    EasyLoading.dismiss();
                  },
                  onTapGallery: () async {
                    //
                    Navigator.pop(context);
                    await selectImage(
                      ImageSource.gallery,
                    );
                    EasyLoading.dismiss();

                    //setState(() {});
                  },
                );
              },
              child: Image.asset(
                'assets/Icons/addImage.png',
                height: static.width > 500 ? 22.h : 26.h,
                width: static.width > 500 ? 22.w : 26.w,
              ),
            )),
      ],
    );
  }

  Widget fieldForFullName() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.midGreyColor.withOpacity(.7),
        placeholder: 'Full Name',
        isSecure: false,
        controller: generalWatch.editNameController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForEmail() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        isEnable: false,
        postfixIconColor: null,
        placeholderColor: theme.midGreyColor.withOpacity(.7),
        placeholder: 'Your Email',
        isSecure: false,
        controller: generalWatch.editEmailController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForMobile() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        keyboard: TextInputType.phone,
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.midGreyColor.withOpacity(.7),
        placeholder: 'Mobile Number',
        isSecure: false,
        controller: generalWatch.editMobileController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForAddress() {
    return GestureDetector(
      onTap: () async {
        var status = await Permission.location.status;
        if (Platform.isAndroid) {
          if (status == PermissionStatus.denied ||
              status == PermissionStatus.permanentlyDenied) {
            AppUtils().exitingAppDialog(context,
                headingTextColor: theme.blackColor,
                dialogColor: theme.whiteColor,
                icon: 'alertAnime',
                heading: 'Alert',
                message:
                "Enable location access for precise delivery tracking and to ensure timely order arrivals.",
                positiveButton: 'ALLOW',
                negativeButton: 'CANCEL', positiveAction: () async {
                  if (await AppUtils().requestLocationPermission(context)) {
                    LocationResult result =
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlacePicker(
                          mapKey,
                        )));
                    if (result != null) {
                      Navigator.pop(context);
                    }
                    generalWatch.editAddressController.text =
                        result.formattedAddress.toString();
                  } else {
                    Navigator.pop(context);
                    openAppSettings();
                  }
                }, negativeAction: () {
                  Navigator.pop(context);
                });
          } else {
            LocationResult result =
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PlacePicker(
                  mapKey,
                )));

            generalWatch.editAddressController.text =
                result.formattedAddress.toString();
          }
        }
        else {
          LocationResult result =
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  PlacePicker(
                    mapKey,
                  )));
          generalWatch.editAddressController.text =
              result.formattedAddress.toString();
        }
        //
        // read.userLatLongUpdate(lat:result.latLng.latitude ,long:result.latLng.longitude );
      },
      child: Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        child: utils.inputField(
          isEnable: false,
          textColor: theme.blackColor,
          postfixIcon: null,
          postfixClick: () async {},
          postfixIconColor: theme.blackColor,
          postFixIconSize: 16.h,
          placeholderColor: theme.midGreyColor.withOpacity(.7),
          placeholder: 'Address',
          isSecure: false,
          controller: generalWatch.editAddressController,
          maxLines: 1,
        ),
      ),
    );
  }

  Widget updateButton() {
    return Container(
      width: static.width,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
      margin: EdgeInsets.only(top: 80.h),
      child: utils.button(
        textSize: static.width > 550 ? 10.sp : 20.sp,
        text: 'Update',
        buttonColor: theme.orangeColor,
        borderColor: theme.orangeColor,
        fontFamily: 'finalBold',
        ontap: () async {
          if (generalWatch.editNameController.text.isEmpty) {
            utils.showToast(context, message: 'Enter your full name');
          } else if (!regexName
              .hasMatch(generalWatch.editNameController.text)) {
            utils.showToast(context,
                message: generalWatch.editNameController.text.length < 3 ||
                        generalWatch.editNameController.text.length > 35
                    ? 'Full name must be 3 to 35 characters long'
                    : 'Please enter valid name');
          } else if (generalWatch.editEmailController.text.isEmpty) {
            utils.showToast(context, message: 'Enter email address');
          } else if (!regexEmail
              .hasMatch(generalWatch.editEmailController.text)) {
            utils.showToast(context, message: 'Enter valid email');
          } else if (generalWatch.editMobileController.text.isEmpty) {
            utils.showToast(context,
                message: 'Enter phone no with country code');
          }
          // else if (!regexPhone
          //     .hasMatch(generalWatch.editNameController.text)) {
          //   utils.showToast(context,
          //       message: 'Please Enter a valid Phone Number');
          // }
          else if (generalWatch.editAddressController.text.isEmpty) {
            utils.showToast(context, message: 'Enter your permanent address');
          } else {
            await generalRead.fetchingUserStaticData();
            generalRead.editProfileApi(context,
                image: generalWatch.profilePhotoValue);
          }
        },
        textColor: theme.whiteColor,
        width: static.width,
      ),
    );
  }

  Future selectImage(ImageSource sourceImage) async {
    selectedImage = await ImagePicker().pickImage(source: sourceImage);
    if (selectedImage != null) {
      generalRead.updateRestrictUserNavigation(value: true);
      EasyLoading.show(status: 'Image Uploading');
      croppedFile = (await ImageCropper().cropImage(
        sourcePath: selectedImage!.path,
        aspectRatio: CropAspectRatio(ratioX: 620, ratioY: 620),
      ));

      EasyLoading.dismiss();

      if (croppedFile != null) {
        print("The cropped path is:" + croppedFile!.path);
        selectedFile = File(croppedFile!.path);

        print("There the image 1:" + selectedImage.toString());
        print("There the image 1:" + File(croppedFile!.path).toString());

        await generalRead.uploadImageApi(context,
            file: File(croppedFile!.path), isSignup: false);

        generalRead.updateRestrictUserNavigation();
      }
    } else {
      print('No image selected.');
    }
  }
}
