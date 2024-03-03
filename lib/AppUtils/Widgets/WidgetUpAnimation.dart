import 'package:flutter/material.dart';

class WidgetUpAnimation extends StatelessWidget {
  WidgetUpAnimation({
    Key? key,
    required this.child,
    required this.top_to_bottom,
    required this.height,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final bool top_to_bottom;
  final height;

  @override
  Widget build(BuildContext context) {
    // final height = height;
    double fadeValue = 0.5;
    return top_to_bottom
        ? TweenAnimationBuilder(
            tween:
                Tween<double>(begin: top_to_bottom ? -height : height, end: 0),
            duration: duration,
            curve: Curves.fastOutSlowIn,
            builder: (context, double value, _) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
          )
        : TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: 0),
            duration: duration,
            curve: Curves.fastOutSlowIn,
            builder: (context, double value, _) {
              if (value <= 0.8) {
                // Fade in from 0% to 80% of the animation
                fadeValue = 0.5 + ((1 - value) / 0.8) * 0.5;
              }

              // Ensure fadeValue stays within the valid range of 0.5 to 1
              fadeValue = fadeValue.clamp(0.5, 1.0);

              print("Fade Value $fadeValue");
              return Transform.translate(
                offset: Offset(0, height * value),
                child: Opacity(
                  opacity: fadeValue,
                  // Fade out when value is 0 (reached the center)
                  child: child,
                ),
              );
            },
          );
  }
}
