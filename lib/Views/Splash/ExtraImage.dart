// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Offset imageOffset = Offset(0.0, 0.0); // Initial offset of the image
//   double imageSize = 100.0; // Adjust this size as needed
//   bool scrollEnabled = false; // Variable to track if scrolling is enabled
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Drag Image'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Scroll Image'),
//                 Switch(
//                   activeColor: Colors.orange,
//                   value: scrollEnabled,
//                   onChanged: (value) {
//                     setState(() {
//                       scrollEnabled = value;
//                     });
//                   },
//                 ),
//               ],
//             ),
//             Container(
//               height: MediaQuery
//                   .of(context)
//                   .size
//                   .height * 0.45,
//               width: MediaQuery
//                   .of(context)
//                   .size
//                   .width * 0.80,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: MediaQuery
//                         .of(context)
//                         .size
//                         .height * 0.45,
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.80,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/Images/leftArm.png',
//                     height: MediaQuery
//                         .of(context)
//                         .size
//                         .height * .30,
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * .60,
//                     fit: BoxFit.contain,
//                   ),
//                   // Conditionally apply panning behavior
//                   Positioned(
//                     left: scrollEnabled ? imageOffset.dx : 0.0,
//                     top: scrollEnabled ? imageOffset.dy : 0.0,
//                     child: GestureDetector(
//                       onPanUpdate: (details) {
//                         // Get the size of the parent container
//
//
//                         if (scrollEnabled) {
//                           final parentSize = Size(
//                             MediaQuery
//                                 .of(context)
//                                 .size
//                                 .width * 0.80,
//                             MediaQuery
//                                 .of(context)
//                                 .size
//                                 .height * 0.45,
//                           );
//
//                           setState(() {
//                             // Update the image's position, ensuring it stays within the parent bounds
//                             imageOffset = Offset(
//                               (imageOffset.dx + details.delta.dx).clamp(
//                                 0.0, parentSize.width - imageSize,),
//                               (imageOffset.dy + details.delta.dy).clamp(
//                                 0.0, parentSize.height - imageSize,),
//                             );
//                           });
//                         }
//                       },
//                       child: Image.asset(
//                         'assets/Images/Tattoo.png',
//                         height: imageSize,
//                         width: imageSize,
//                         color: Colors.orange,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//
//
//
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragAndDropScreen(),
    );
  }
}

class DragAndDropScreen extends StatefulWidget {
  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  double redBoxPositionX = 0.0;
  double redBoxPositionY = 0.0;
  bool isInsideBlackContainer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Drop Example'),
      ),
      body: Stack(
        children: [
          // Half-screen black container
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height,
            color: Colors.black,
          ),

          // Full-screen draggable red container
          Positioned(
            left: redBoxPositionX,
            top: redBoxPositionY,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  redBoxPositionX += details.delta.dx;
                  redBoxPositionY += details.delta.dy;

                  // Check if the red box is inside the black container
                  isInsideBlackContainer = redBoxPositionX <
                      MediaQuery.of(context).size.width / 2;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
                decoration: isInsideBlackContainer
                    ? BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
