import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/splash_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';

class TaskManagerMobileApp extends StatelessWidget {
  const TaskManagerMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        colorSchemeSeed: AppColors.backgroundColor,
        scaffoldBackgroundColor: AppColors.foregroundColor,
        textTheme: const TextTheme(),
        inputDecorationTheme: _buildInputDecorationTheme(),
        elevatedButtonTheme: _buildElevatedButtonThemeData(),
      ),
    );
  }

  InputDecorationTheme _buildInputDecorationTheme() {
    return InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Colors.grey
      ),
      border: _buildOutlineInputBorder(),
      errorBorder: _buildOutlineInputBorder(),
      focusedErrorBorder: _buildOutlineInputBorder(),
      focusedBorder: _buildOutlineInputBorder(),
      disabledBorder: _buildOutlineInputBorder(),
      enabledBorder: _buildOutlineInputBorder(),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: AppColors.backgroundColor,
      ),
    );
  }

  ElevatedButtonThemeData _buildElevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: AppColors.foregroundColor,
        backgroundColor: AppColors.backgroundColor,
        fixedSize: const Size(double.maxFinite, 56),
      ),
    );
  }
}
