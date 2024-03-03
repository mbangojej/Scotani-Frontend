import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/custom_images.dart';
import 'package:skincanvas/Models/design_apparel_user.dart';
import 'package:skincanvas/Views/Authentication/LoginScreen.dart';
import 'package:skincanvas/Views/Authentication/SignupScreen.dart';

class LoginAndSignUpHelper {
  BuildContext context;

  LoginAndSignUpHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  // Widget backGroundImage() {
  //   return Container(
  //     width: static.width,
  //     child: Stack(
  //       children: [
  //         Image.asset(
  //           'assets/Images/splashBackGround.png',
  //           fit: BoxFit.cover,
  //           width: static.width,
  //           height: static.height,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget topImages() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 245.h,
            width: 172.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/Images/img1.png",
                  ),
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: 245.h,
            width: 139.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/Images/img2.png",
                  ),
                  fit: BoxFit.cover,
                )),
          ),
        ],
      ),
    );
  }

  Widget logoText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/Icons/logo.png",
                scale: 6,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/Icons/scotani_name.png",
                    scale: 7,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.whiteColor),
                      borderRadius: BorderRadius.circular(42.r),
                    ),
                    child: Text(
                      "Apparel",
                      style: utils.labelStyle(theme.whiteColor),
                    ),
                  )
                ],
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration: Duration(milliseconds: 800),
                        pageBuilder: (_, __, ___) => SignUpScreen(
                          isFromLogin: false,
                        ),
                        // Replace with your desired destination screen
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(-0.18, 0.0); // Start from left
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: theme.redColor,
                      borderRadius: BorderRadius.circular(42.r),
                    ),
                    child: Text(
                      "Get Started",
                      style: utils.labelStyle(theme.whiteColor),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 800),
                          pageBuilder: (_, __, ___) => LoginScreen(),
                          // Replace with your desired destination screen
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-0.18, 0.0); // Start from left
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end)
                                .chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);
                            return SlideTransition(
                                position: offsetAnimation, child: child);
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Login",
                      style: utils.labelStyle(theme.whiteColor),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Join us on our journey as we explore the intersection of fashion and technology, creation not just clothing, but personalized stories on body.",
            style: utils.labelStyle(theme.whiteColor),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            "Join us on our journey as we explore the",
            style: utils.labelStyle(theme.midGreyColor),
          ),
        ],
      ),
    );
  }

  List<DesignApparelUsers> imagesList = [
    DesignApparelUsers(id: '1', imgUrl: 'assets/Images/img3.png'),
    DesignApparelUsers(id: '1', imgUrl: 'assets/Images/img4.png'),
    DesignApparelUsers(id: '1', imgUrl: 'assets/Images/img5.png'),
    DesignApparelUsers(id: '1', imgUrl: 'assets/Images/img6.png'),
    DesignApparelUsers(id: '1', imgUrl: 'assets/Images/img7.png'),
    DesignApparelUsers(id: '1', imgUrl: 'assets/Images/img8.png'),
  ];
  Widget images() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: imagesList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 3),
            itemBuilder: (context, index) {
              return CustomImages(designApparelUsers: imagesList[index]);
            }),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "900k",
                style: utils.labelStyleB(
                  theme.redColor,
                ),
              ),
              Text(
                "Designs",
                style: utils.labelStyleB(theme.whiteColor),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "3k",
                style: utils.labelStyleB(theme.redColor),
              ),
              Text(
                "Apparel",
                style: utils.labelStyleB(theme.whiteColor),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "4 Millons",
                style: utils.labelStyleB(theme.redColor),
              ),
              Text(
                "Users",
                style: utils.labelStyleB(theme.whiteColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //   Widget backGroundImage() {
  //   return Container(
  //     width: static.width,
  //     child: Stack(
  //       children: [
  //         Image.asset(
  //           'assets/Images/splashBackGround.png',
  //           fit: BoxFit.cover,
  //           width: static.width,
  //           height: static.height,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  image() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: static.width,
      height: static.height * .44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0.r),
              bottomRight: Radius.circular(30.0.r))),
      child: Image.asset(
        'assets/Images/loginSignUpImage.png',
        fit: BoxFit.cover,
      ),
    );
  }

  circularTriangle() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.orangeColor,
      ),
      child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.9, // Adjust this value to control the triangle size
        heightFactor: 0.9, // Adjust this value to control the triangle size
        child: Image.asset(
          'assets/Icons/appIcon.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  headingText() {
    return Column(
      children: [
        // RichText(
        //   text: TextSpan(
        //       text: 'NU',
        //       style: utils.generalHeading(theme.orangeColor,
        //           fontFamily: 'bebasBold', size: 44.sp),
        //       children: <TextSpan>[
        //         TextSpan(
        //           text: ' Canva',
        //           style: utils.generalHeading(theme.midLightGreyColor,
        //               fontFamily: 'bebasBold', size: 42.sp),
        //         )
        //       ]),
        // ),
        Text(
          'SCOTANI',
          style: utils.generalHeading(theme.orangeColor,
              fontFamily: 'bebasBold', size: 42.sp),
        ),
        Text(
          'DESIGN YOUR TATTOO',
          style: utils.smallLabelStyle(theme.midGreyColor, letterSpacing: 2.0),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
          child: Text(
            'Express Your Style with Customizable Temporary Tattoos',
            style: utils.labelStyle(theme.midGreyColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget loginButton() {
    return Hero(
      tag: 'LoginSignUp',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: static.width,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 20.sp,
            text: 'Login',
            buttonColor: theme.orangeColor,
            borderColor: theme.orangeColor,
            fontFamily: 'finalBold',
            ontap: () {
              // Navigator.pushNamed(context, route.loginScreenRoute);
              // Navigator.push(
              //     context,
              //     PageRouteBuilder(
              //         transitionDuration: Duration(milliseconds: 1500),
              //         pageBuilder: (_, __, ___) => LoginScreen()));

              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 800),
                  pageBuilder: (_, __, ___) => LoginScreen(),
                  // Replace with your desired destination screen
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-0.18, 0.0); // Start from left
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            },
            textColor: theme.whiteColor,
            width: static.width,
          ),
        ),
      ),
    );
  }

  Widget createAnAccountButton() {
    return Hero(
      tag: 'CreateAccountToSignup',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: static.width,
          child: utils.button(
            textSize: static.width > 550 ? 10.sp : 18.sp,
            text: 'Create an Account',
            buttonColor: theme.transparentColor,
            borderColor: theme.orangeColor,
            fontFamily: 'finalBold',
            ontap: () {
              // Navigator.pushNamed(context, route.signUpScreenRoute);
              // Navigator.push(
              //     context,
              //     PageRouteBuilder(
              //         transitionDuration: Duration(milliseconds: 1500),
              //         pageBuilder: (_, __, ___) => SignUpScreen(
              //               isFromLogin: false,
              //             )));
              Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 800),
                  pageBuilder: (_, __, ___) => SignUpScreen(
                    isFromLogin: false,
                  ),
                  // Replace with your desired destination screen
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(-0.18, 0.0); // Start from left
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation, child: child);
                  },
                ),
              );
            },
            textColor: theme.orangeColor,
            width: static.width,
          ),
        ),
      ),
    );
  }
}
