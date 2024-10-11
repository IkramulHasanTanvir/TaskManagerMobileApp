import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get Started',
                style: textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Start with sing up or sing in',
                style: textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height / 5),
              ElevatedButton(
                onPressed: () {},
                child: const Text('SING UP'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.foregroundColor,
                  foregroundColor: AppColors.backgroundColor,
                  side: const BorderSide(color: AppColors.backgroundColor),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SingInScreen(),
                      ),
                      (_) => false);
                },
                child: const Text('SING IN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
