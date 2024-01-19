import 'package:flutter/material.dart';

class TitlesTextWidget extends StatelessWidget {
  const TitlesTextWidget(
      {super.key,
      this.label,
      this.color,
      this.fontSize = 20,
      this.fontWeight,
      this.maxLines});
  final String? label;
  final Color? color;
  final double fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      label!,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
