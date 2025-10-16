import 'package:bondly/core/utils/extentions.dart';
import 'package:bondly/shared/global_widgets/text.dart';
import 'package:flutter/material.dart';
import '../../core/themes/app_theme.dart';

class CTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const CTextField({
    super.key,
    required this.controller,
    required this.label,
    this.onChange,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CText(
          padding: EdgeInsets.only(bottom: 5),
          text: label,
          fontSize: isMobile?AppTheme.small:AppTheme.medium,
          fontWeight: FontWeight.w400,
          textColor: AppTheme.black.withValues(alpha: 0.7),
        ),
        TextFormField(
          controller: controller,
          cursorColor: AppTheme.primaryColor,
          onChanged: onChange,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: AppTheme.black,
            fontSize: isMobile?AppTheme.medium:AppTheme.large,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            filled: false,
            //fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: label,
            hintStyle: TextStyle(
              color: AppTheme.grey,
              fontSize: AppTheme.medium,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.black.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.black.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.secondaryColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
