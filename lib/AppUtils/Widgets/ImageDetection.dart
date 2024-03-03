// import 'package:flutter/material.dart';
//
// class ImageDetectionApp extends StatefulWidget {
//   @override
//   _ImageDetectionAppState createState() => _ImageDetectionAppState();
// }
//
// class _ImageDetectionAppState extends State<ImageDetectionApp> {
//   String fixedImagePath = 'assets/Images/chest.png'; // Replace with your fixed image path
//   List<dynamic>? _recognitions;
//
//   @override
//   void initState() {
//     super.initState();
//     loadModel();
//     detectImage(fixedImagePath);
//   }
//
//   Future<void> loadModel() async {
//     try {
//       String? modelPath = await Tflite.loadModel(
//         model: 'assets/AR/mobilenet_quant_v1_224.tflite',
//         labels: 'assets/AR/labels.txt',
//       );
//       print('Model loaded: $modelPath');
//     } catch (e) {
//       print('Error loading model: $e');
//     }
//   }
//
//   Future<void> detectImage(String imagePath) async {
//     try {
//       var recognitions = await Tflite.runModelOnImage(
//         path: imagePath,
//         imageMean: 0.0,
//         imageStd: 255.0,
//         numResults: 5,
//         threshold: 0.2,
//       );
//       setState(() {
//         _recognitions = recognitions;
//       });
//     } catch (e) {
//       print('Error detecting image: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Image Detection App'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(fixedImagePath, height: 200, width: 200),
//             SizedBox(height: 20),
//             _recognitions != null
//                 ? Column(
//               children: [
//                 for (var recognition in _recognitions!)
//                   Text(
//                     '${recognition['label']} - ${recognition['confidence']}',
//                     style: TextStyle(fontSize: 18),
//                   ),
//               ],
//             )
//                 : CircularProgressIndicator(),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.grey[300],
                  child: Image.asset('assets/sample_image.jpg'), // Replace with your image
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: 200,
                    color: Colors.black.withOpacity(0.7),
                    child: TextField(
                      controller: textController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Enter Text',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreviewScreen(
                      image: 'assets/sample_image.jpg', // Replace with the path to your image
                      text: textController.text,
                    ),
                  ),
                );
              },
              child: Text('Preview'),
            ),
          ],
        ),
      ),
    );
  }
}


class PreviewScreen extends StatelessWidget {
  final String image;
  final String text;

  PreviewScreen({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.grey[300],
              child: Image.asset(image), // Display the image from the previous screen
            ),
            SizedBox(height: 20),
            Text(
              text, // Display the text from the previous screen
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
