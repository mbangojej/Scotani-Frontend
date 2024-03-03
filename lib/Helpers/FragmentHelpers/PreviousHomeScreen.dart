import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/AppConstant/Routes.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';
import 'package:skincanvas/AppUtils/Widgets/DiscoverDesignWidget.dart';
import 'package:skincanvas/AppUtils/Widgets/FeaturedWidgets.dart';
import 'package:skincanvas/AppUtils/Widgets/InspirationalWidgets.dart';
import 'package:skincanvas/Controllers/AuthenticationProvider.dart';
import 'package:skincanvas/main.dart';

class PreviousHomeHelper {
  BuildContext context;

  PreviousHomeHelper(this.context);

  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  var route = Routes();

  var authWatch =
      navigatorkey.currentContext!.watch<AuthenticationController>();
  var authRead = navigatorkey.currentContext!.read<AuthenticationController>();

  Widget welcomeText() {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: 20.w) + EdgeInsets.only(top: 20.h),
      width: static.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: static.width * .6,
            child: Text(
              'Welcome Tristan! ',
              style: utils.generalHeadingBold(theme.whiteColor,
                  size: 26.sp, fontFamily: 'finalBold'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
                color: theme.lightBlackColor,
                shape: BoxShape.circle,
                border: Border.all(color: theme.greyColor.withOpacity(.8))),
            child: Container(
                width: 45.w,
                height: 45.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.lightGreyColor,
                ),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_itBJHsvrxXpbXwTxpvpwx8qbdyOnunFQ8w&usqp=CAU',
                  fit: BoxFit.cover,
                )),
          )
        ],
      ),
    );
  }

  Widget fieldForSearch() {
    return Container(
      padding: EdgeInsets.only(left: 22.w, right: 25.w),
      child: utils.inputField(
          textColor: theme.blackColor,
          placeholderColor: theme.midGreyColor.withOpacity(.7),
          placeholder: 'Find Inspirations',
          isSecure: false,
          controller: authWatch.loginEmailController,
          maxLines: 1,
          prefixIcon: 'search',
          prefixClick: () {},
          prefixIconColor: theme.greyColor,
          preFixIconSize: 20.w),
    );
  }

  Widget inspirationsHeadingText() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: EdgeInsets.only(
              left: 20.0.w, right: 20.w, top: 10.h, bottom: 10.h),
          child: Text(
            'Inspirations',
            style:
                utils.xHeadingStyleB(theme.whiteColor, fontFamily: "finalBold"),
            textAlign: TextAlign.start,
          )),
    );
  }

  Widget InspirationalWidgets() {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // controller: scrollController,
          child: Wrap(
            alignment: WrapAlignment.start,
            children: [
              SizedBox(
                width: 10.w,
              ),
              // InspirationalContainer(
              //   image:
              //       'https://h6f9r7p4.rocketcdn.me/wp-content/uploads/2020/07/Women-with-Tattoos-Miami-640x500.jpg',
              //   text: 'Classic',
              // ),
              // InspirationalContainer(
              //   image:
              //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0JCu6_qusQgHn1fNupdw4_MHXyiHvpZ-TA&usqp=CAU',
              //   text: 'Realism',
              // ),
              // InspirationalContainer(
              //   image:
              //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmE79MmO0nzIhrFG6wd_7DrLT4KOCTX5nDqA&usqp=CAU',
              //   text: 'Blackwork',
              // ),
              // InspirationalContainer(
              //   image:
              //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJoN75L05RFi16TM1yuT2-zHmSwrPJ4jUU3g&usqp=CAU',
              //   text: 'Pokger',
              // ),

              DiscoverDesignContainer(
                image:
                    'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/f820e398-3050-438b-91a9-e985898def17/spark-womens-shoes-w4WdlF.png',
                heading: 'Classic',
                price: '\$ 2.00',
                subHeading: 'Your dream tato Lora is sia breeze debs.',
                onTap: () {},
              ),
              DiscoverDesignContainer(
                image:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3-f75U1ncOYJHvL5p2lhtYOtKZGD7HMzWsA&usqp=CAU',
                heading: 'Realism',
                price: '\$ 4.00',
                subHeading: 'Your dream tato Lora is sia breeze debs.',
                onTap: () {},
              ),
              DiscoverDesignContainer(
                image:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ18b6pQFyXN12vICYKTQB3fx-u_UQZKReOcQ&usqp=CAU',
                heading: 'Blackwork',
                price: '\$ 5.00',
                subHeading: 'Your dream tato Lora is sia breeze debs.',
                onTap: () {},
              ),
              DiscoverDesignContainer(
                image:
                    'https://hi-tec.co.za/wp-content/uploads/2022/02/WOMENS-HIKING-PANTS-BALSAM-GREEN-T012420-2.jpg',
                heading: 'Pokger',
                price: '\$ 1.00',
                subHeading: 'Your dream tato Lora is sia breeze debs.',
                onTap: () {},
              ),

              SizedBox(
                width: 10.w,
              ),
            ],
          ),
        ));
  }

  Widget discoverDesign() {
    return Container(
      height: static.height * .42,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.h),
            width: double.infinity,
            height: static.height * .14,
            decoration: BoxDecoration(color: theme.orangeColor),
            child: Container(
                padding: EdgeInsets.only(
                    left: 20.0.w, right: 20.w, top: 20.h, bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Discover Designs',
                      style: utils.xHeadingStyleB(theme.whiteColor,
                          fontFamily: "finalBold"),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'View All',
                      style: utils.labelStyle(theme.whiteColor,
                          fontFamily: "finalBold"),
                      textAlign: TextAlign.start,
                    ),
                  ],
                )),
          ),
          Positioned(
            top: 70.h,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // controller: scrollController,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://h6f9r7p4.rocketcdn.me/wp-content/uploads/2020/07/Women-with-Tattoos-Miami-640x500.jpg',
                        heading: 'Classic',
                        price: '\$ 2.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0JCu6_qusQgHn1fNupdw4_MHXyiHvpZ-TA&usqp=CAU',
                        heading: 'Realism',
                        price: '\$ 4.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmE79MmO0nzIhrFG6wd_7DrLT4KOCTX5nDqA&usqp=CAU',
                        heading: 'Blackwork',
                        price: '\$ 5.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJoN75L05RFi16TM1yuT2-zHmSwrPJ4jUU3g&usqp=CAU',
                        heading: 'Pokger',
                        price: '\$ 1.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget featureDesign() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
          child: Text(
            'Feature Designs',
            style:
                utils.xHeadingStyleB(theme.whiteColor, fontFamily: "finalBold"),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // controller: scrollController,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  FeaturedContainer(
                      image:
                          'https://h6f9r7p4.rocketcdn.me/wp-content/uploads/2020/07/Women-with-Tattoos-Miami-640x500.jpg',
                      heading: 'Classic',
                      price: '\$ 2.00',
                      subHeading: 'Your dream tato Lora is sia breeze debs.'),
                  FeaturedContainer(
                      image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP0JCu6_qusQgHn1fNupdw4_MHXyiHvpZ-TA&usqp=CAU',
                      heading: 'Realism',
                      price: '\$ 4.00',
                      subHeading: 'Your dream tato Lora is sia breeze debs.'),
                  FeaturedContainer(
                      image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmE79MmO0nzIhrFG6wd_7DrLT4KOCTX5nDqA&usqp=CAU',
                      heading: 'Blackwork',
                      price: '\$ 5.00',
                      subHeading: 'Your dream tato Lora is sia breeze debs.'),
                  FeaturedContainer(
                      image:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJoN75L05RFi16TM1yuT2-zHmSwrPJ4jUU3g&usqp=CAU',
                      heading: 'Pokger',
                      price: '\$ 1.00',
                      subHeading: 'Your dream tato Lora is sia breeze debs.'),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              ),
            )),
      ],
    ));
  }

  Widget otherProductDesign() {
    return Container(
        padding: EdgeInsets.symmetric(
              vertical: 10.h,
            ) +
            EdgeInsets.only(top: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
              child: Text(
                'Other Products',
                style: utils.xHeadingStyleB(theme.whiteColor,
                    fontFamily: "finalBold"),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  // controller: scrollController,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/f820e398-3050-438b-91a9-e985898def17/spark-womens-shoes-w4WdlF.png',
                        heading: 'Classic',
                        price: '\$ 2.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3-f75U1ncOYJHvL5p2lhtYOtKZGD7HMzWsA&usqp=CAU',
                        heading: 'Realism',
                        price: '\$ 4.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ18b6pQFyXN12vICYKTQB3fx-u_UQZKReOcQ&usqp=CAU',
                        heading: 'Blackwork',
                        price: '\$ 5.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      DiscoverDesignContainer(
                        image:
                            'https://hi-tec.co.za/wp-content/uploads/2022/02/WOMENS-HIKING-PANTS-BALSAM-GREEN-T012420-2.jpg',
                        heading: 'Pokger',
                        price: '\$ 1.00',
                        subHeading: 'Your dream tato Lora is sia breeze debs.',
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
