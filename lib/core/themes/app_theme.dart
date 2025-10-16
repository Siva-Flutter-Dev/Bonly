import 'package:flutter/material.dart';

class AppTheme {

  /// app theme colors
  static const Color primaryColor = Color(0xFF023047);
  static const Color gradient2 = Color(0xFF023954); /// for gradient use only
  static const Color gradient3 = Color(0xFF034161); /// for gradient use only
  static const Color gradient4 = Color(0xFF03527A); /// for gradient use only
  static const Color secondaryColor = Color(0xFF219EBC);
  static const Color lightColor = Color(0xFF8ECAE6);
  static const Color selectiveColor = Color(0xFFFFB703);
  static const Color extraColor = Color(0xFFFB8500);

  /// for text or additional uses
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFffffff);
  static const Color grey = Color(0xFF9AA0A6);

  /// app theme gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryColor,gradient2,gradient3,gradient4],
    stops: [0.0,0.13,0.25,0.5],
    begin: AlignmentGeometry.topCenter,
    end: AlignmentGeometry.bottomCenter
  );
  static const LinearGradient zebraGradient = LinearGradient(
    colors: [gradient4,gradient3,gradient2],
    stops: [0.0,0.5,1],
    tileMode: TileMode.repeated,
    transform: GradientRotation(1),
    begin: AlignmentGeometry.centerLeft,
    end: AlignmentGeometry.centerRight
  );

  /// Font Size
  static const double tiny = 10;
  static const double small = 12;
  static const double medium = 14;
  static const double large = 16;
  static const double big = 18;
  static const double ultraBig = 20;

  static const String assets = 'assets/images/';
}