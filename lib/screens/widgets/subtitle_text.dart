import 'package:flutter/material.dart';

class SubTitleTextWidget extends StatelessWidget {
  const SubTitleTextWidget(
      {super.key,
      this.label,
      this.fontSize,
      this.fontWeight,
      this.decoration,
      this.color,
      this.fontStyle});

  final String? label;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final Color? color;
  final FontStyle? fontStyle;
  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        decoration: decoration,
        color: color,
        fontStyle: fontStyle,
      ),
    );
  }
}
