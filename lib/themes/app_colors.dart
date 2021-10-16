import 'package:flutter/cupertino.dart';

class AppColors {
  static const Color primary = Color(0xFFF27A54);
  static const Color secondary = Color(0xFFA154F2);
  static const Color tertiary = Color(0xFF6FCF97);
  static const Color lightGrey = Color(0xFFF2F4F7);
  static const Color grey = Color(0xFFCBCFD4);
  static const Color darkGrey = Color(0xFF3C444C);
  static const Color appBlack = Color(0xFF30363D);
  static const Color error = Color(0xFFF30070);
  static const Color appWhite = Color(0xFFE5E5E5);
  static Color opaqueBlack = appBlack.withOpacity(0.8);

  // app gradient
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );
  static LinearGradient gradientWithOpacity = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary.withOpacity(0.7), secondary.withOpacity(0.7)],
  );
}
