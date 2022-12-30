import 'package:flutter/material.dart';
import '../themes/colors.dart';
import '../themes/font_size.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      this.fontSize = AppFontSize.sixteen,
      this.fontColor = AppColors.black,
      this.fontWeight})
      : super(key: key);
  final String text;
  final double fontSize;
  final Color? fontColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Text(
      text,
      style: TextStyle(
          fontSize: media.width * fontSize,
          fontWeight: fontWeight,
          color: fontColor,
          fontFamily: "Oswald"),
    );
  }
}
