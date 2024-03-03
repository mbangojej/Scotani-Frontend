import 'package:flutter/material.dart';
import 'package:skincanvas/AppConstant/Theme.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = ThemeColors();
    return GestureDetector(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: theme.midGreyColor,
        ),
        child: Radio<bool>(
          groupValue: groupValue,
          value: value,
          activeColor: theme.orangeColor,
          onChanged: (bool? newValue) {
            onChanged(newValue!);
          },
        ),
      ),
    );
  }
}
