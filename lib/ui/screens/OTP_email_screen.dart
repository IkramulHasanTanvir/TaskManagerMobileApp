import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/screens/PIN_verify_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';
import 'package:task_manager_mobile_app/ui/widgets/snackBarMessage.dart';

class OTPEmailScreen extends StatefulWidget {
  const OTPEmailScreen({super.key});

  @override
  State<OTPEmailScreen> createState() => _OTPEmailScreenState();
}

class _OTPEmailScreenState extends State<OTPEmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool _verifyEmailInProgress = false;

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
              _buildOTPEmailForm(),
              const SizedBox(height: 44),
              _buildHaveAccountSection(),
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
            'Your Email\nAddress!',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'A 6 digit verification pin will send to your email address',
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildOTPEmailForm() {
    return Column(
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
        const SizedBox(height: 32),
        Visibility(
          visible: !_verifyEmailInProgress,
          replacement: const CircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapOTPVerifyScreen,
            child: const Text('CONTINUE'),
          ),
        ),
      ],
    );
  }

  Widget _buildHaveAccountSection() {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.grey[900]),
          text: "Have account? ",
          children: [
            TextSpan(
              style: const TextStyle(
                color: AppColors.backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              text: 'Sing In',
              recognizer: TapGestureRecognizer()..onTap = _onTapSingInScreen,
            ),
          ],
        ),
      ),
    );
  }

  void _onTapOTPVerifyScreen() {
    if (_emailController.text != '') {
      _verifyEmail();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PINVerifyScreen(
            verifyEmail: _emailController.text.trim(),
          ),
        ),
      );
    }
  }

  Future<void> _verifyEmail() async {
    _verifyEmailInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.recoverVerifyEmail(_emailController.text),
    );
    _verifyEmailInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      snackBarMessage(context, response.responseBody['data']);
    } else {
      snackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapSingInScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SingInScreen()),
        (_) => false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
