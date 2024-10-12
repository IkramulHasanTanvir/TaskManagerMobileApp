import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/profile_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/widgets/app_bar_background.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: AppBarBackground(
        child: _buildAppBarListTile(context),
      ),
    );
  }

  Widget _buildAppBarListTile(BuildContext context) {
    String imageUrl = '';
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 24),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          maxRadius: 32,
          child: imageUrl.isNotEmpty
              ? Image.network(imageUrl)
              : const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 32,
                ),
        ),
        title: const Text(
          'Tanvir Hridoy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'ikramulhasantanvir@gmail.com',
          style: TextStyle(color: Colors.black),
        ),
        trailing: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SingInScreen(),
                ),
                (_) => false);
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(104);
}
