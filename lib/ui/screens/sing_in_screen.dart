import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/controller/auth_controller.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/screens/OTP_email_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/main_button_nav_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_up_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _obscureText = true;

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        title: _buildTitleSection(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 44.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildSingInForm(),
              TextButton(
                onPressed: _onTapOTPEmailScreen,
                child: const Text('Forgot password?'),
              ),
              const SizedBox(height: 44),
              _buildSingUpSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome\nBack!',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hey! Good to see you again',
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSingInForm() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          const SizedBox(height: 44),
          TextFormField(
            controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              suffixIcon: Icon(Icons.email_outlined),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter valid email';
              }
              if (!value!.contains('@')) {
                return "Enter valid email '@'";
              }
              if (!value.contains('.com')) {
                return "Enter valid email '.com'";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  _obscureText = !_obscureText;
                  setState(() {});
                },
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter valid password';
              }
              if (value!.length < 6) {
                return 'Enter valid password must 6 character';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          Visibility(
            visible: !_inProgress,
            replacement: const CircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTapSingInButton,
              child: const Text('SING IN'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSingUpSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.grey[900]),
          text: "Don't have an account? ",
          children: [
            TextSpan(
              style: const TextStyle(
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              text: 'Sing Up',
              recognizer: TapGestureRecognizer()..onTap = _onTapSingUpScreen,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapSingInButton() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    _singIn();
  }

  Future<void> _singIn() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text,
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );
    _inProgress = false;

    if (response.isSuccess) {
      final String token = response.responseBody['token'];
      await AuthController.saveAccessToken(token);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainButtonNavScreen()),
          (_) => false);
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.backgroundColor,
          content: Text(response.errorMessage),
        ),
      );
    }
  }

  void _onTapOTPEmailScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OTPEmailScreen(),
      ),
    );
  }

  void _onTapSingUpScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SingUpScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
