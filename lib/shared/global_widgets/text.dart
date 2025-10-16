import 'package:flutter/material.dart';

import '../../core/themes/app_theme.dart';

class CText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? padding;
  const CText({super.key, required this.text, this.fontSize, this.fontWeight, this.textColor, this.overflow, this.textAlign, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding??EdgeInsets.zero,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            fontSize: fontSize??AppTheme.medium,
            fontWeight: fontWeight??FontWeight.w500,
            color: textColor??AppTheme.black,
            overflow: overflow??TextOverflow.ellipsis
        ),
      ),
    );
  }
}
