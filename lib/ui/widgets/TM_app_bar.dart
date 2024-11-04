import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/models/user_model.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/screens/profile_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/widgets/app_bar_background.dart';
import 'package:task_manager_mobile_app/ui/widgets/snackBarMessage.dart';
import '../controller/auth_controller.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
  });

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(104);
}

class _TMAppBarState extends State<TMAppBar> {

  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
    getProfileDetails();
  }
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
              ? Image.network('')
              : const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 32,
                ),
        ),
        title: Text(
          userModel.fullName ?? 'Hy',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          userModel.email ?? '',
          style: const TextStyle(color: Colors.black),
        ),
        trailing: IconButton(
          onPressed: () async {
            await AuthController.clearAccessToken();
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

  Future<void> getProfileDetails() async {
    userModel = await AuthController.getUserData() ?? UserModel();
    NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.profileDetails);
    if (response.isSuccess) {
      userModel = UserModel.fromJson(response.responseBody);
      AuthController.saveUserData(userModel);
      setState(() {
      });
    } else {
      snackBarMessage(context, response.errorMessage, true);
    }
  }
}
