import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(56),
          ),
        ),
      ),
      Container(
        height: 156,
        decoration: const BoxDecoration(
          color: AppColors.foregroundColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(56),
          ),
        ),
      ),
      Container(
        height: 152,
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(56),
          ),
        ),
        child: Center(
          child: child,
        ),
      ),
    ]);
  }
}
