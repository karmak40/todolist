import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'constants/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO List',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppConstants.primaryDarkBg,
        colorScheme: ColorScheme.dark(
          primary: AppConstants.accentColor,
          surface: AppConstants.cardBackgroundColor,
          error: Colors.red,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppConstants.primaryDarkBg,
          foregroundColor: AppConstants.textColor,
        ),
        cardTheme: CardThemeData(
          color: AppConstants.cardBackgroundColor,
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppConstants.accentColor,
          foregroundColor: AppConstants.textColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: AppConstants.cardBackgroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            borderSide: const BorderSide(color: AppConstants.textSecondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            borderSide: const BorderSide(color: AppConstants.textSecondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
            borderSide: const BorderSide(color: AppConstants.accentColor),
          ),
          hintStyle: const TextStyle(color: AppConstants.textSecondary),
          labelStyle: const TextStyle(color: AppConstants.textSecondary),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
