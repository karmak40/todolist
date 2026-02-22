import 'package:flutter/material.dart';

class AppConstants {
  // Colors - Dark Theme
  static const Color primaryDarkBg = Color(0xFF1E1D2E);
  static const Color accentColor = Color(0xFF3562FF);
  static const Color textActiveTab = Color(0xFF3562FF);
  static const Color textInactiveTab = Color(0xFFC3C2C7);
  static const Color backgroundColor = Color(0xFF1E1D2E);
  static const Color cardBackgroundColor = Color(0xFF2D2B3D);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFC3C2C7);
  static const Color primaryColor = Color(0xFF3562FF);
  static const Color greyColor = Color(0xFFC3C2C7);
  static const Color greenColor = Color(0xFF00C853);

  // Padding and spacing
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Font sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 24.0;

  // Border radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 20.0;

  // App name
  static const String appName = 'TODO List';

  // Default avatar size
  static const double avatarRadiusSmall = 20.0;
  static const double avatarRadiusMedium = 30.0;

  // Default duration
  static const int defaultDuration = 30; // minutes

  // Animation duration
  static const Duration animationDuration = Duration(milliseconds: 300);

  // Board card colors (cycling)
  static const List<Color> boardCardColors = [
    Color(0xFF9eecff), // Cyan/Light blue
    Color(0xFFfff971), // Yellow
    Color(0xFFffffff), // White
  ];

  static Color getBoardCardColor(int index) {
    return boardCardColors[index % boardCardColors.length];
  }
}
