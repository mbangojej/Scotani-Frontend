import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/Controllers/GeneralProvider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/Controllers/OrdersAndCheckOutAndWishlistProvider.dart';
import 'package:skincanvas/NotificationServices/local_notification_service.dart';
import 'package:skincanvas/Views/AddToWishList/FavouriteProductScreen.dart';
import 'package:skincanvas/Views/Authentication/EmailVerificaitonScreen.dart';
import 'package:skincanvas/Views/Authentication/ForgetPasswordScreen.dart';
import 'package:skincanvas/Views/Authentication/ResetPasswordScreen.dart';
import 'package:skincanvas/Views/Authentication/SignupScreen.dart';
import 'package:skincanvas/Views/Cart&Checkout/CheckoutScreen.dart';
import 'package:skincanvas/Views/Cart&Checkout/OrderHistoryScreen.dart';
import 'package:skincanvas/Views/CreateProduct/CreateProductScreen.dart';
import 'package:skincanvas/Views/CreateTattoo/CreateTattooScreen.dart';
import 'package:skincanvas/Views/Cart&Checkout/MyCartScreen.dart';
import 'package:skincanvas/Views/EditTattooAndProduct/EditTattooAndProductScreen.dart';
import 'package:skincanvas/Views/FragmentScreens/BottomNavigationBar.dart';
import 'package:skincanvas/Views/Onboarding/OnboardingScreen.dart';
import 'package:skincanvas/Views/Authentication/LoginAndSignupScreen.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';
import 'package:skincanvas/Views/PlaceOrder/OrderDetailScreen.dart';
import 'package:skincanvas/Views/PlaceOrder/PlaceOrderScreen.dart';
import 'package:skincanvas/Views/ProductsRelatedScreens/ProductDetailScreen.dart';
import 'package:skincanvas/Views/ProductsRelatedScreens/SelectCategoryProductScreen.dart';
import 'package:skincanvas/Views/SettingScreens/AboutUsScreen.dart';
import 'package:skincanvas/Views/SettingScreens/ChangePasswordScreen.dart';
import 'package:skincanvas/Views/SettingScreens/EditProfileScreen.dart';
import 'package:skincanvas/Views/SettingScreens/PrivacyAndPolicyScreen.dart';
import 'package:skincanvas/Views/Splash/Splash.dart';
import 'package:skincanvas/firebase_options.dart';

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp();
  LocalNotificationService.initialize();

  // bool isTablet =
  //     ScreenUtil().screenWidth > 600; // Adjust the width threshold as needed

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationController>(
          create: (_) => AuthenticationController(),
        ),
        ChangeNotifierProvider<GeneralController>(
          create: (_) => GeneralController(),
        ),
        ChangeNotifierProvider<HomeController>(
          create: (_) => HomeController(),
        ),
        ChangeNotifierProvider<OrderCheckOutWishlistController>(
          create: (_) => OrderCheckOutWishlistController(),
        ),
      ],
      child: MyApp(),
    ),
  );

  configLoading();
  FirebaseFunctions();
}

//........... Loading customization.........//
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 12.0
    ..progressColor = ThemeColors().whiteColor
    ..backgroundColor = ThemeColors().redColor
    ..indicatorColor = ThemeColors().whiteColor
    ..textColor = ThemeColors().whiteColor
    ..maskColor = ThemeColors().whiteColor
    ..userInteractions = false
    ..dismissOnTap = false;
}

//............ Firebase Notification Functions...........//

void FirebaseFunctions() {
  // 1. This method call when app in terminated state and you get a notification
  // when you click on notification app open from terminated state and you can get notification data in this method
  FirebaseMessaging.instance.getInitialMessage().then(
    (message) {
      print("FirebaseMessaging.instance.getInitialMessage");
      if (message != null)
        LocalNotificationService.createAndDisplayNotification(message);
    },
  );

  // 2. This method only call when App in foreground it mean app must be opened
  FirebaseMessaging.onMessage.listen(
    (message) {
      print("FirebaseMessaging.oneMssage.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        LocalNotificationService.createAndDisplayNotification(message);
      }
    },
  );

  // 3. This method only call when App in background and not terminated(not closed)
  FirebaseMessaging.onMessageOpenedApp.listen(
    (message) {
      print("FirebaseMessaging.onMessageOpenedApp.listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        LocalNotificationService.createAndDisplayNotification(message);
      }
    },
  );
}

//.......................... Notification Service Close ..................//

class MyApp extends StatelessWidget {
  var theme = ThemeColors();
  var routes = Routes();

  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: (context, child) => MaterialApp(
        navigatorKey: navigatorkey,
        title: 'Skin Canvas',
        debugShowCheckedModeBanner: false,
        initialRoute: routes.splashScreenRoute,
        builder: EasyLoading.init(),
        routes: {
          routes.splashScreenRoute: (context) => SplashScreen(),
          routes.onBoardingRoute: (context) => OnBoardingScreen(),
          routes.loginAndSignUpRoute: (context) => LoginAndSignUpScreen(),
          routes.loginScreenRoute: (context) => LoginScreen(),
          routes.forgetPasswordScreenRoute: (context) => ForgetPasswordScreen(),
          routes.signUpScreenRoute: (context) =>
              SignUpScreen(isFromLogin: false),
          routes.resetPasswordScreenRoute: (context) => ResetPasswordScreen(),
          routes.createTattooScreenRoute: (context) => CreateTattooScreen(),
          routes.emailVerificationScreenRoute: (context) =>
              EmailVerificationScreen(),
          routes.bottomNavigationScreenRoute: (context) => BottomNavigation(),
          routes.selectCategoryScreenRoute: (context) => SelectCategoryScreen(),
          routes.myCartScreenRoute: (context) => MyCartScreen(),
          routes.editTattooAndProductScreenRoute: (context) =>
              EditTattooAndProductScreen(),
          routes.orderHistoryStatusScreenRoute: (context) =>
              OrderHistoryStatusScreen(),
          routes.orderDetailScreenRoute: (context) => OrderDetailScreen(),
          routes.placeOrderScreenRoute: (context) => PlaceOrderScreen(),
          routes.emailVerificationScreenRoute: (context) =>
              EmailVerificationScreen(),
          routes.checkOutScreenRoute: (context) => CheckOutScreen(),
          routes.editProfileScreenRoute: (context) => EditProfileScreen(),
          routes.changePasswordScreenRoute: (context) => ChangePasswordScreen(),
          routes.privacyAndPolicyScreenRoute: (context) =>
              PrivacyAndPolicyScreen(),
          routes.aboutUsScreenRoute: (context) => AboutUsScreen(),
          routes.myWishListScreenRoute: (context) => MyWishListScreen(),
          routes.createProductScreenRoute: (context) => CreateProductScreen(),
          routes.productDetailScreenRoute: (context) => ProductDetailScreen(),
        },
        theme: ThemeData(
          primarySwatch: theme.kPrimaryColor,
        ),
      ),
    );
  }
}
