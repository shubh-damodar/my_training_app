import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final double? factor;
  final double? height;

  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.factor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle(
        color: color,
        size: size,
        weight: fontWeight,
        height: height,
      ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      softWrap: maxLines == null,
    );
  }
}

TextStyle textStyle({
  double? size,
  Color? color,
  FontWeight? weight,
  double? height,
  TextDecoration? underline,
}) {
  return TextStyle(
    decoration: underline,
    fontSize: size ?? 14,
    color: color ?? Colors.black,
    fontWeight: weight ?? FontWeight.normal,
    height: height,
  );
}
