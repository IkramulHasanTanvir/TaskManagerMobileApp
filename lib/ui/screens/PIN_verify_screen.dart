import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_mobile_app/ui/screens/set_pass_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';

class PINVerifyScreen extends StatefulWidget {
  const PINVerifyScreen({super.key});

  @override
  State<PINVerifyScreen> createState() => _PINVerifyScreenState();
}

class _PINVerifyScreenState extends State<PINVerifyScreen> {
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
            'PIN\nVerification!',
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PinCodeTextField(
            backgroundColor: Colors.transparent,
            appContext: (context),
            length: 6,
            pinTheme: PinTheme(
              fieldWidth: 44,
              fieldHeight: 56,
              activeFillColor: Colors.transparent,
              selectedFillColor: Colors.transparent,
              inactiveFillColor: Colors.transparent,
              inactiveColor: Colors.grey[200],
              selectedColor: Colors.grey,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
            ),
            enableActiveFill: true,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapSetPasswordScreen,
          child: const Text('VERIFY'),
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

  void _onTapSetPasswordScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SetPassScreen(),
      ),
    );
  }

  void _onTapSingInScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SingInScreen()),
        (_) => false);
  }
}
