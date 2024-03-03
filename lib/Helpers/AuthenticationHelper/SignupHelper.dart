import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';
import 'package:skincanvas/main.dart';

class SignUpHelper {
  BuildContext context;

  SignUpHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  XFile? selectedImage;
  var croppedFile;

  // File? selectedFile;

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();
  var generalRead = navigatorkey.currentContext!.read<GeneralController>();
  var generalWatch = navigatorkey.currentContext!.watch<GeneralController>();

  Widget signUpText() {
    return Container(
      padding: EdgeInsets.only(top: 30.h),
      width: static.width,
      child: Column(
        children: [
          Hero(
            tag: 'CreateAccountToSignup',
            child: Text(
              'Sign Up',
              style: utils.generalHeadingBold(theme.whiteColor,
                  size: static.width > 550 ? 20.sp : 26.sp,
                  fontFamily: 'finalBold'),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            'Add your details to sign up',
            style: utils.smallLabelStyle(
              theme.midGreyColor,
            ),
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
            child: authWatch.selectedImageByFile != null
                ? Image.file(
                    authWatch.selectedImageByFile as File,
                    fit: BoxFit.cover,
                  )
                : FractionallySizedBox(
                    alignment: Alignment.center,
                    widthFactor: 0.4,
                    // Adjust this value to control the triangle size
                    heightFactor: 0.4,
                    // Adjust this value to control the triangle size
                    child: Icon(
                      CupertinoIcons.photo_camera_solid,
                      size: static.width > 550 ? 32.w : 42.w,
                      color: theme.blackColor.withOpacity(.7),
                    ),
                  ),
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(navigatorkey.currentContext!).size.width > 550
                ? 10.h
                : 20.h,
            right: MediaQuery.of(navigatorkey.currentContext!).size.width > 550
                ? 8.w
                : 0.h,
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
                    Navigator.pop(context);
                    await selectImage(
                      ImageSource.gallery,
                    );
                    EasyLoading.dismiss();
                  },
                );
              },
              child: Image.asset(
                'assets/Icons/addImage.png',
                height: 26.h,
                width: 26.w,
              ),
            )),
      ],
    );
  }

  Widget fieldForFullName() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        keyboard: TextInputType.name,
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.blackColor,
        placeholder: 'Full Name',
        isSecure: false,
        controller: authWatch.signupNameController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForEmail() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        keyboard: TextInputType.emailAddress,
        textColor: theme.blackColor,
        postfixIcon: null,
        postfixClick: () async {},
        postfixIconColor: null,
        placeholderColor: theme.blackColor,
        placeholder: 'Email',
        isSecure: false,
        controller: authWatch.signupEmailController,
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
        placeholderColor: theme.blackColor,
        placeholder: 'Mobile Number',
        isSecure: false,
        controller: authWatch.signupMobileController,
        maxLines: 1,
      ),
    );
  }

  Widget fieldForPassword() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: utils.inputField(
        textColor: theme.blackColor,
        postfixIcon: !authWatch.isSignupPassVisible ? 'eye' : 'eyeSlash',
        postfixClick: () async {
          authRead.signupPasswordUpdator(!authWatch.isSignupPassVisible);
        },
        postfixIconColor: theme.blackColor,
        postFixIconSize: 16.h,
        placeholderColor: theme.blackColor,
        placeholder: 'Password',
        isSecure: authWatch.isSignupPassVisible,
        controller: authWatch.signupPasswordController,
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
                authWatch.signupAddressController.text =
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

            authWatch.signupAddressController.text =
                result.formattedAddress.toString();
          }
        } else {
          LocationResult result =
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlacePicker(
                        mapKey,
                      )));
          authWatch.signupAddressController.text =
              result.formattedAddress.toString();
        }

        // read.userLatLongUpdate(lat:result.latLng.latitude ,long:result.latLng.longitude );
      },
      child: Hero(
        tag: 'LoginToSignup',
        child: Container(
          padding: EdgeInsets.only(left: 15.w, right: 15.w),
          child: utils.inputField(
            isEnable: false,
            textColor: theme.blackColor,
            postfixIcon: null,
            postfixClick: () async {},
            postfixIconColor: theme.blackColor,
            postFixIconSize: 16.h,
            placeholderColor: theme.blackColor,
            placeholder: 'Address',
            isSecure: false,
            controller: authWatch.signupAddressController,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return Hero(
      tag: 'LoginToSignupButton',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: static.width,
          padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(navigatorkey.currentContext!).size.width > 550
                      ? 12.w
                      : 15.w,
              vertical: 18.h),
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 20.sp,
            text: 'Sign Up',
            buttonColor: theme.redColor,
            borderColor: theme.redColor,
            fontFamily: 'finalBold',
            ontap: () {
              // if (authWatch.selectedImageByFile == null) {
              //   utils.showToast(context, message: 'Add profile image');
              // }
              if (authWatch.signupNameController.text.isEmpty) {
                utils.showToast(context, message: 'Enter your full name');
              } else if (!regexName
                  .hasMatch(authWatch.signupNameController.text)) {
                utils.showToast(context,
                    message: 'Please enter valid full name');
              } else if (authWatch.signupEmailController.text.isEmpty) {
                utils.showToast(context, message: 'Enter email address');
              } else if (!regexEmail
                  .hasMatch(authWatch.signupEmailController.text)) {
                utils.showToast(context, message: 'Enter valid email');
              } else if (authWatch.signupMobileController.text.isEmpty) {
                utils.showToast(context,
                    message: 'Enter phone no with country code');
              } else if (!regexPhone
                  .hasMatch(authWatch.signupMobileController.text)) {
                utils.showToast(context, message: 'Enter valid phone number');
              } else if (authWatch.signupPasswordController.text.isEmpty) {
                utils.showToast(context, message: 'Enter password');
              } else if (!regexPassword
                  .hasMatch(authWatch.signupPasswordController.text)) {
                utils.showToast(context,
                    message:
                        'Passwords need to be minimum 8 characters long with uppercase, lowercase, a number, and a special character.');
              } else if (authWatch.signupAddressController.text.isEmpty) {
                utils.showToast(context,
                    message: 'Enter your permanent address');
              } else {
                authRead.signupApi(
                  context,
                  image: generalWatch.profilePhotoValue,
                );
              }
            },
            textColor: theme.whiteColor,
            width: static.width,
          ),
        ),
      ),
    );
  }

  alreadyHaveAccountText() {
    return GestureDetector(
      onTap: () {
        authRead.selectedImageUpdation(file: null);
        authWatch.signupNameController.clear();
        authWatch.signupEmailController.clear();
        authWatch.signupMobileController.clear();
        authWatch.signupPasswordController.clear();
        authWatch.signupAddressController.clear();
        // Navigator.pushNamed(context, route.loginScreenRoute);
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1500),
                pageBuilder: (_, __, ___) => LoginScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 20.h),
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
              text: 'Already have an account?  ',
              style: utils.labelStyle(
                theme.whiteColor,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Login ',
                  style: utils.labelStyleB(
                    theme.redColor,
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Future selectImage(ImageSource sourceImage) async {
    selectedImage = await ImagePicker().pickImage(source: sourceImage);
    if (selectedImage != null) {
      generalWatch.updateRestrictUserNavigation(value: true);
      EasyLoading.show(status: 'Image Uploading');
      croppedFile = (await ImageCropper().cropImage(
        sourcePath: selectedImage!.path,
        aspectRatio: CropAspectRatio(ratioX: 620, ratioY: 620),
      ));

      EasyLoading.dismiss();

      if (croppedFile != null) {
        print("The cropped path is: ${croppedFile.runtimeType}");

        authRead.selectedImageUpdation(
          file: croppedFile,
        );

        await generalRead.uploadImageApi(context,
            file: File(croppedFile!.path));

        // authRead.selectedImageUpdation(file: File(croppedFile!.path), string: croppedFile!.path);
      }
      generalWatch.updateRestrictUserNavigation();
    } else {
      print('No image selected.');
      generalWatch.updateRestrictUserNavigation();
    }
  }
}
