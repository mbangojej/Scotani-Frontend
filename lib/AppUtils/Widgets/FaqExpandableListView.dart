// // ignore_for_file: unnecessary_new
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skincanvas/AppConstant/Static.dart';
// import 'package:skincanvas/AppConstant/Theme.dart';
// import 'package:skincanvas/AppUtils/AppUtils.dart';
//
// class FAQExpandableListView extends StatefulWidget {
//   String? title;
//   String? description;
//
//   FAQExpandableListView({ this.title,this.description});
//
//   @override
//   _FAQExpandableListViewState createState() => new _FAQExpandableListViewState();
// }
//
// class _FAQExpandableListViewState extends State<FAQExpandableListView> with SingleTickerProviderStateMixin{
//   bool expandFlag = false;
//   var utils=AppUtils();
//   var theme = ThemeColors();
//   var static = Statics();
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       margin: EdgeInsets.symmetric(vertical: 10.h),
//       width: MediaQuery.of(context).size.width,
//       // padding: EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0),bottomLeft: Radius.circular(16.0),topLeft: Radius.circular(16.0),topRight: Radius.circular(16.0)),
//         color: theme.backGroundColor,
//       ), child: new Column(
//       children: [
//         Container(
//           margin: EdgeInsets.symmetric(horizontal: 10.w),
//
//           decoration: BoxDecoration(
//             color: theme.backGroundColor,
//           ),
//           padding:  EdgeInsets.symmetric(horizontal: 10.0,),
//           child:  Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child: Container(
//                   child: Text(
//                     widget.title!,
//                     style: utils.labelStyle(theme.midGreyColor,fontFamily: 'finalBold')
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10,),
//               GestureDetector(
//                 onTap: (){
//                   setState(() {
//                     expandFlag = !expandFlag;
//                   });
//                 },
//                 child: Container(
//                 //  padding: EdgeInsets.symmetric(horizontal: .w,vertical: 4.w),
//                   decoration: BoxDecoration(
//                     color: theme.transparentColor,
//                     shape: BoxShape.circle,
//                     border:Border.all(color: expandFlag?theme.orangeColor:theme.midGreyColor)
//                   ),
//                   child:  Icon(
//                         expandFlag ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                         color:expandFlag?theme.orangeColor: theme.midGreyColor,
//                         size: 20.0.sp,
//                       ),
//                 ),
//               ),
//
//             ],
//           ),
//         ),
//
//
//
//
//         Container(
//           margin: EdgeInsets.only(top: 10.h),
//           width: static.width,
//           height: 1.h,
//           decoration: BoxDecoration(
//             color: theme.lightBlackColor
//           ),
//         ),
//
//
//         ExpandableContainer(
//             expanded: expandFlag,
//             child: SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.h),
//                 decoration: BoxDecoration(
//                     color: theme.lightBlackColor
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20.w,),
//                     child: Text(widget.description!,style: utils.labelStyle(theme.whiteColor,fontFamily: "finalBook"))),
//               ),
//             )
//
//         ),
//
//
//       ],
//     ),
//     );
//   }
// }
//
//
//
// class ExpandableContainer extends StatefulWidget {
//   final Widget child;
//   final bool expanded;
//
//   ExpandableContainer({required this.child, this.expanded = false});
//
//   @override
//   _ExpandableContainerState createState() => _ExpandableContainerState();
// }
//
// class _ExpandableContainerState extends State<ExpandableContainer> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 300),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSize(
//       duration: _controller.duration!,
//       curve: Curves.easeInOut,
//       alignment: Alignment.topCenter,
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           minHeight: widget.expanded ? 0.0 : 1.0,
//           maxHeight: double.infinity,
//         ),
//         child: SingleChildScrollView(
//           child: widget.child,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skincanvas/AppConstant/Static.dart';
import 'package:skincanvas/AppConstant/Theme.dart';
import 'package:skincanvas/AppUtils/AppUtils.dart';

class FAQExpandableListView extends StatefulWidget {
  String? title;
  String? description;

  FAQExpandableListView({this.title, this.description});

  @override
  _FAQExpandableListViewState createState() => _FAQExpandableListViewState();
}

class _FAQExpandableListViewState extends State<FAQExpandableListView>
    with SingleTickerProviderStateMixin {
  bool expandFlag = false;
  var utils = AppUtils();
  var theme = ThemeColors();
  var static = Statics();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: theme.backGroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expandFlag = !expandFlag;
                if (expandFlag) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: theme.backGroundColor,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.title!,
                      style: utils.labelStyle(theme.midGreyColor,
                          fontFamily: 'finalBold'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: theme.transparentColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: .5,
                            color: expandFlag
                                ? theme.orangeColor
                                : theme.midGreyColor.withOpacity(.5))),
                    child: Icon(
                      expandFlag
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: expandFlag
                          ? theme.orangeColor
                          : theme.midGreyColor.withOpacity(.5),
                      size:  static.width>550? 16.sp:20.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            //margin: EdgeInsets.only(top: 10.h),
            width: static.width,
            height: 1.h,
            decoration: BoxDecoration(color: theme.lightBlackColor),
          ),
          expandFlag
              ? AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  // Adjust the duration as needed
                  curve: Curves.easeInOut,
                  // Use a different easing curve for a slower effect
                  alignment:
                      expandFlag ? Alignment.topCenter : Alignment.bottomCenter,
                  child: Container(
                    width: static.width,
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 20.w,
                    ),
                    decoration: BoxDecoration(color: theme.lightBlackColor),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.description!,
                        style: utils.labelStyle(
                          theme.whiteColor,
                          fontFamily: "finalBook",
                        ),
                      ),
                    ),
                  ))
              : Container(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
