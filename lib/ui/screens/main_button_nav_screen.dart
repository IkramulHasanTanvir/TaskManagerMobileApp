import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/cancel_task_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/completed_task_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/new_task_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/progress_task_screen.dart';
import 'package:task_manager_mobile_app/ui/widgets/TM_app_bar.dart';
import 'package:task_manager_mobile_app/ui/widgets/TM_bottom_nav_bar.dart';

class MainButtonNavScreen extends StatefulWidget {
  const MainButtonNavScreen({super.key});

  @override
  State<MainButtonNavScreen> createState() => _MainButtonNavScreenState();
}

class _MainButtonNavScreenState extends State<MainButtonNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: _screens[_selectedIndex],
      bottomNavigationBar: TMBottomNavBar(
        selectedIndex: _selectedIndex,
        onTapChange: (int newValue) {
          _selectedIndex = newValue;
          setState(() {});
        },
      ),
    );
  }
}
