import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/main.dart';

class Statics {
  //............... HOST URL..........//

  //var baseURL = 'https://scotani-client.arhamsoft.org/v1/api';
  // var baseURL = 'https://skin-canvas.kasarhamsoft.org/v1/api';

  // var baseURL = 'https://app.scotani.com/v1/api';
  var baseURL = "http://localhost:8081/v1/api";

  var tattooAndGraphicGenerationURL =
      'https://api.openai.com/v1/images/generations';
  var tattooGenerationURL = 'https://api.openai.com/v1/images/generations';
  var edgesCuttingURL = 'https://python.scotani.com/arhamsoft/skin_canvas/';
  var removeBackGroundURL =
      'https://skin-canvas.arhamsoft.org/v1/api/auth/upload-multiple-images';
  var pythonBackGroundURL = 'https://python.scotani.com/arhamsoft/bg_removal/';
  var authURL = '/auth/';
  var notificationsURL = '/notifications/';
  var userURL = '/user/';
  var faq = '/faqs/';
  var settingURL = '/settings/';
  var productURL = '/product/';
  var wishlistURL = '/wishlist/';
  var cart = '/cart/';
  var orderURL = '/order/';
  var sizeGroup = 'get-size-group?all=1';
  var imprint = '/imprints/';
  var getColors = 'get-colors';
  var xAuthToken = 'F5r3w4y!2wr';
  var bearerToken = '';
  var openDalleToken = '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';
  var getProfile = 'get-profile';

  ///..... Apis end params.........//

  var signup = 'signup';
  var signin = 'signin';
  var forgetPassword = 'forgot-password';
  var verifyingOTP = 'verify-otp';
  var resendOTP = 'resend-otp';
  var changePassword = 'change-password';
  var getCMS = 'get-cms';
  var list = 'list';
  var listCategories = 'list-categories';
  var listProducts = 'list-products';
  var editProfile = 'edit-profile';
  var logout = 'logout';
  var uploadImage = 'upload-image';
  var addToWishlist = 'add-to-wishlist';
  var addToCart = 'add-to-cart';
  var updateCart = 'update-cart-quantity';
  var removeCart = 'remove-from-cart';
  var checkout = 'checkout';
  var confirmTransaction = 'confirm-transaction';
  var validateCoupan = 'validate-coupon';
  var history = 'history';
  var reOrder = 're-order';
  var delete = 'delete';
  var cancelOrder = 'cancel-order';
  var onBoardingScreen = 'onboarding-screen';
  var changeStatus = 'change-status';
  var changeNotificationStatus = 'change-notification-status';
  var reportIssueBug = 'report-issue-bug';
  var detail = 'detail';
  var getVariationPrice = 'get-variantion-price';
  var getSettings = 'get-settings';
  var deleteAccount = 'account-deactivation-request';

  var width = MediaQuery.of(navigatorkey.currentContext!).size.width;
  var height = MediaQuery.of(navigatorkey.currentContext!).size.height;

  final xxlHeading =
      MediaQuery.of(navigatorkey.currentContext!).size.width > 550
          ? 16.sp
          : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
                  MediaQuery.of(navigatorkey.currentContext!).size.width < 550
              ? 22.0.sp
              : 20.sp;
  final xlHeading = MediaQuery.of(navigatorkey.currentContext!).size.width > 550
      ? 14.sp
      : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
              MediaQuery.of(navigatorkey.currentContext!).size.width < 550
          ? 20.0.sp
          : 18.sp;
  final xHeading = MediaQuery.of(navigatorkey.currentContext!).size.width > 550
      ? 12.sp
      : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
              MediaQuery.of(navigatorkey.currentContext!).size.width < 550
          ? 18.0.sp
          : 16.sp;
  final heading = MediaQuery.of(navigatorkey.currentContext!).size.width > 550
      ? 10.sp
      : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
              MediaQuery.of(navigatorkey.currentContext!).size.width < 550
          ? 16.0.sp
          : 14.0.sp;
  final label = MediaQuery.of(navigatorkey.currentContext!).size.width > 550
      ? 8.sp
      : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
              MediaQuery.of(navigatorkey.currentContext!).size.width < 550
          ? 14.0.sp
          : 12.0.sp;
  final smallLabel =
      MediaQuery.of(navigatorkey.currentContext!).size.width > 550
          ? 6.sp
          : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
                  MediaQuery.of(navigatorkey.currentContext!).size.width < 550
              ? 12.0.sp
              : 10.0.sp;
  final xSmallLabel =
      MediaQuery.of(navigatorkey.currentContext!).size.width > 550
          ? 5.sp
          : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
                  MediaQuery.of(navigatorkey.currentContext!).size.width < 550
              ? 10.0.sp
              : 8.0.sp;
  final xlSmallLabel =
      MediaQuery.of(navigatorkey.currentContext!).size.width > 550
          ? 4.sp
          : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
                  MediaQuery.of(navigatorkey.currentContext!).size.width < 550
              ? 8.0.sp
              : 6.0.sp;
  final xxlSmallLabel =
      MediaQuery.of(navigatorkey.currentContext!).size.width > 550
          ? 2.sp
          : MediaQuery.of(navigatorkey.currentContext!).size.width > 412 &&
                  MediaQuery.of(navigatorkey.currentContext!).size.width < 550
              ? 6.0.sp
              : 4.0.sp;

  final bold = FontWeight.bold;
  final normal = FontWeight.normal;
  final light = FontWeight.w300;

  ///....... Shared Preferenecs store variables........///

  String fcmToken = 'fcmToken';
  String userToken = 'Token';
  String userID = 'userID';
  String email = 'email';
  String phone = 'phone';
  String address = 'address';
  String fullName = 'fullName';
  String profilePhoto = 'profilePhoto';
  String isVerified = 'isVerified';
  String notificationStatusString = 'notificationStatus';

  String isRememberStatus = 'isRememberStatus';
  String isRememberEmail = 'isRememberEmail';
  String isRememberPassword = 'isRememberPassword';

  String isFirstTime = 'isFirstTime';
  String canCouponApply = "canCouponApply";

  String discountCouponString = 'discountCouponString';
}

//............ Globally Define...........//
String? fcmTokenValue;
int? isVerifiedValue;

String? rememberEmail;
String? rememberPassword;
bool? rememberStatus;

String couponCode = '';

bool? firstTimeValue = false;
int apiResponse = 0;

String userToken = '';
String userID = '';

//............. REGEX Expressions Initializers........//

String emailPattern =
    r"^[a-zA-Z0-9](?:[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\.[a-zA-Z]{2,})$";

String nameExpression = r'^[A-Za-z][A-Za-z ]{3,35}$';
String phoneExpression = r'^(?:\+?)(?:[0-9]\s?){6,14}[0-9]$';
String passwordExpression =
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$';
String reportAnErrorExpression =
    r'^[A-Za-z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\-][A-Za-z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\- ]*$';

RegExp regexEmail = RegExp(emailPattern);
RegExp regexName = RegExp(nameExpression);
RegExp regexPhone = RegExp(phoneExpression);
RegExp regexPassword = RegExp(passwordExpression);
RegExp regexReportAndError = RegExp(reportAnErrorExpression);

//................. MAP KEY...............//

String mapKey = 'AIzaSyDmN4B517QI_4311M9qyEIheA6ymCYguco';
String priceKey = '\$';
