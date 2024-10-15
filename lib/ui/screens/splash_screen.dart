import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/controller/auth_controller.dart';
import 'package:task_manager_mobile_app/ui/screens/get_started_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/main_button_nav_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _moveNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();
    if(AuthController.isLoggedIn()){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainButtonNavScreen(),
        ),
            (_) => false,
      );
    }else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStartedScreen(),
        ),
            (_) => false,
      );
    }
  }

  @override
  void initState() {
    _moveNextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Image.asset(
                'assets/images/task.png',
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Task Manager',
              style: TextStyle(
                color: AppColors.foregroundColor,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
