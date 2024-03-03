import 'package:flutter/material.dart';

class TattooOverlay extends StatefulWidget {
  @override
  State<TattooOverlay> createState() => _TattooOverlayState();

}

class _TattooOverlayState extends State<TattooOverlay> {
  double scale = 1.0;
  double previousScale = 1.0;
  Offset offset = Offset.zero;
  Offset previousOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    // Asset paths of your arm and tattoo images
    String armImagePath = 'assets/Images/biceps.png';
    String tattooImagePath = 'assets/Images/tattoo.png';

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onScaleStart: (details) {
                previousScale = scale;
                previousOffset = offset;
              },
              onScaleUpdate: (details) {
                setState(() {
                  scale = previousScale * details.scale;
                  offset = details.focalPoint - (previousOffset * scale);
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Arm image
                  Image.asset(armImagePath),

                  // Tattoo image
                  Positioned(
                    top: offset.dy,
                    left: offset.dx,
                    width: 100 * scale, // Adjust the width as needed
                    height: 100 * scale, // Adjust the height as needed
                    child: Image.asset(tattooImagePath),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
