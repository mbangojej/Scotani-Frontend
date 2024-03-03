import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skincanvas/Controllers/HomeProvider.dart';
import 'package:skincanvas/main.dart';

class _SliderIndicatorPainter extends CustomPainter {
  final double position;

  _SliderIndicatorPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(position, size.height / 2), 10.r, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    return true;
  }
}

/// ........................... Color Slider for Change Image Color ................................. ///

class ImageColorPicker extends StatefulWidget {
  final double width;

  ImageColorPicker({required this.width});

  @override
  ImageColorPickerState createState() => ImageColorPickerState();
}

class ImageColorPickerState extends State<ImageColorPicker> {
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  final List<Color> _colors = [
    Color.fromARGB(255, 255, 255, 255),
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 128, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 128, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 128, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 128, 128, 128),
    Color.fromARGB(255, 0, 0, 0),
  ];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeRead.updateImageCurrentColor(color: calculateSelectedColor(homeWatch.imageColorSliderPositionList[homeWatch.selectableImageIndex]));
      homeRead.updateImageShadeSliderPosition(position: widget.width / 2); //center the shader selector
      homeRead.updateColor(
          // calculateShadedColor(homeWatch
          // .imageShadeSliderPositionList[homeWatch.selectableImageIndex]));
          calculateSelectedColor(homeWatch
              .imageColorSliderPositionList[homeWatch.selectableImageIndex]));
    });
  }

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    print("New pos: $position");

    homeRead.updateImageCurrentColor(
        color: calculateSelectedColor(homeWatch.imageColorSliderPositionList[homeWatch.selectableImageIndex]));
    homeRead.updateImageColorSliderPosition(position: position);
    homeRead.updateColor(calculateSelectedColor(homeWatch.imageColorSliderPositionList[homeWatch.selectableImageIndex])
        // calculateShadedColor(homeWatch
        //     .imageShadeSliderPositionList[homeWatch.selectableImageIndex]),
        );
  }

  Color calculateShadedColor(double position) {
    double ratio = position / widget.width;
    if (ratio > 0.5) {
      //Calculate new color (values converge to 255 to  make the color lighter)
      int redVal =
          homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex].red !=
                  255
              ? (homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex]
                          .red +
                      (255 -
                              homeWatch
                                  .imageCurrentColorList[
                                      homeWatch.selectableImageIndex]
                                  .red) *
                          (ratio - 0.5) /
                          0.5)
                  .round()
              : 255;
      int greenVal = homeWatch
                  .imageCurrentColorList[homeWatch.selectableImageIndex]
                  .green !=
              255
          ? (homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex]
                      .green +
                  (255 -
                          homeWatch
                              .imageCurrentColorList[
                                  homeWatch.selectableImageIndex]
                              .green) *
                      (ratio - 0.5) /
                      0.5)
              .round()
          : 255;
      int blueVal = homeWatch
                  .imageCurrentColorList[homeWatch.selectableImageIndex].blue !=
              255
          ? (homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex]
                      .blue +
                  (255 -
                          homeWatch
                              .imageCurrentColorList[
                                  homeWatch.selectableImageIndex]
                              .blue) *
                      (ratio - 0.5) /
                      0.5)
              .round()
          : 255;
      print("Ratio > 0.5 ${Color.fromARGB(255, redVal, greenVal, blueVal)}");
      homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex] = Color.fromARGB(255,redVal, greenVal, blueVal);

      return homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex];
    } else if (ratio < 0.5) {
      //Calculate new color (values converge to 0 to make the color darker)
      int redVal =
          homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex].red !=
                  0
              ? (homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex]
                          .red *
                      ratio /
                      0.5)
                  .round()
              : 0;
      int greenVal = homeWatch
                  .imageCurrentColorList[homeWatch.selectableImageIndex]
                  .green !=
              0
          ? (homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex]
                      .green *
                  ratio /
                  0.5)
              .round()
          : 0;
      int blueVal = homeWatch
                  .imageCurrentColorList[homeWatch.selectableImageIndex].blue !=
              0
          ? (homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex]
                      .blue *
                  ratio /
                  0.5)
              .round()
          : 0;
      print("Ratio < 0.5 ${Color.fromARGB(255, redVal, greenVal, blueVal)}");
      homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex] = Color.fromARGB(255,redVal, greenVal, blueVal);
      return homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex];
    } else {
      //return the base color
      return homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex];
    }
  }

  Color calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray = (position / widget.width * (_colors.length - 1));
    print(positionInColorArray);
    int index = positionInColorArray.truncate();
    print("Colored index ${index}");
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex] = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex] =
          Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return homeWatch.imageCurrentColorList[homeWatch.selectableImageIndex];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (DragStartDetails details) {
        print("_-------------------------STARTED DRAG");
        _colorChangeHandler(details.localPosition.dx);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        _colorChangeHandler(details.localPosition.dx);
      },
      onTapDown: (TapDownDetails details) {
        _colorChangeHandler(details.localPosition.dx);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        width: widget.width,
        height: 3.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: _colors),
        ),
        child: CustomPaint(
          painter: _SliderIndicatorPainter(homeWatch
              .imageColorSliderPositionList[homeWatch.selectableImageIndex]),
        ),
      ),
    );
  }
}

/// ........................... Color Slider for Change Desire Text Color ................................. ///

class TextColorPicker extends StatefulWidget {
  final double width;

  TextColorPicker({required this.width});

  @override
  TextColorPickerState createState() => TextColorPickerState();
}

class TextColorPickerState extends State<TextColorPicker> {
  var homeWatch = navigatorkey.currentContext!.watch<HomeController>();
  var homeRead = navigatorkey.currentContext!.read<HomeController>();

  final List<Color> _colors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 128, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 128, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 128, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 128, 128, 128),
    Color.fromARGB(255, 0, 0, 0),
  ];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeRead.updateTextCurrentColor(
          color: calculateSelectedColor(homeWatch.textColorSliderPosition));
      homeRead.updateTextShadeSliderPosition(
          position: widget.width / 2); //center the shader selector
      homeRead.updateColor(
          calculateShadedColor(homeWatch.textShadeSliderPosition!));
    });
  }

  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    print("New pos: $position");

    homeRead.updateTextColorSliderPosition(position: position);
    homeRead.updateTextCurrentColor(
        color: calculateSelectedColor(homeWatch.textColorSliderPosition));
    homeRead
        .updateColor(calculateShadedColor(homeWatch.textShadeSliderPosition!));
  }

  Color calculateShadedColor(double position) {
    double ratio = position / widget.width;
    if (ratio > 0.5) {
      //Calculate new color (values converge to 255 to make the color lighter)
      int redVal = homeWatch.textCurrentColor!.red != 255
          ? (homeWatch.textCurrentColor!.red +
                  (255 - homeWatch.textCurrentColor!.red) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      int greenVal = homeWatch.textCurrentColor!.green != 255
          ? (homeWatch.textCurrentColor!.green +
                  (255 - homeWatch.textCurrentColor!.green) *
                      (ratio - 0.5) /
                      0.5)
              .round()
          : 255;
      int blueVal = homeWatch.textCurrentColor!.blue != 255
          ? (homeWatch.textCurrentColor!.blue +
                  (255 - homeWatch.textCurrentColor!.blue) *
                      (ratio - 0.5) /
                      0.5)
              .round()
          : 255;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else if (ratio < 0.5) {
      //Calculate new color (values converge to 0 to make the color darker)
      int redVal = homeWatch.textCurrentColor!.red != 0
          ? (homeWatch.textCurrentColor!.red * ratio / 0.5).round()
          : 0;
      int greenVal = homeWatch.textCurrentColor!.green != 0
          ? (homeWatch.textCurrentColor!.green * ratio / 0.5).round()
          : 0;
      int blueVal = homeWatch.textCurrentColor!.blue != 0
          ? (homeWatch.textCurrentColor!.blue * ratio / 0.5).round()
          : 0;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else {
      //return the base color
      return homeWatch.textCurrentColor!;
    }
  }

  Color calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray =
        (position / widget.width * (_colors.length - 1));
    print(positionInColorArray);
    int index = positionInColorArray.truncate();
    print(index);
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      homeWatch.textCurrentColor = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      homeWatch.textCurrentColor =
          Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return homeWatch.textCurrentColor!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: (DragStartDetails details) {
        print("_-------------------------STARTED DRAG");
        _colorChangeHandler(details.localPosition.dx);
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        _colorChangeHandler(details.localPosition.dx);
      },
      onTapDown: (TapDownDetails details) {
        _colorChangeHandler(details.localPosition.dx);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        width: widget.width,
        height: 3.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: _colors),
        ),
        child: CustomPaint(
          painter: _SliderIndicatorPainter(homeWatch.textColorSliderPosition),
        ),
      ),
    );
  }
}
