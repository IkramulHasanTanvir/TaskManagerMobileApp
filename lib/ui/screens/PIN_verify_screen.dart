import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_mobile_app/ui/controller/auth_controller.dart';
import 'package:task_manager_mobile_app/ui/data/models/network_response.dart';
import 'package:task_manager_mobile_app/ui/data/services/network_caller.dart';
import 'package:task_manager_mobile_app/ui/data/utils/urls.dart';
import 'package:task_manager_mobile_app/ui/screens/set_pass_screen.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';
import 'package:task_manager_mobile_app/ui/widgets/snackBarMessage.dart';

class PINVerifyScreen extends StatefulWidget {
  const PINVerifyScreen({super.key, required this.verifyEmail});

  final String verifyEmail;

  @override
  State<PINVerifyScreen> createState() => _PINVerifyScreenState();
}

class _PINVerifyScreenState extends State<PINVerifyScreen> {
  final TextEditingController _otpTEController = TextEditingController();

  bool _recoverVerifyOtpInProgress = false;

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
            controller: _otpTEController,
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
        Visibility(
          visible: !_recoverVerifyOtpInProgress,
          replacement: const CircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _onTapSetPasswordScreen,
            child: const Text('VERIFY'),
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

  void _onTapSetPasswordScreen() {
    if (_otpTEController.text != '') {
      _recoverVerifyOtp();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetPassScreen(
            email: widget.verifyEmail,
            otp: _otpTEController.text,
          ),
        ),
      );
    }
  }

  Future<void> _recoverVerifyOtp() async {
    _recoverVerifyOtpInProgress = true;
    setState(() {});

    NetworkResponse networkResponse = await NetworkCaller.getRequest(
        url: Urls.recoverVerifyOtp(widget.verifyEmail, _otpTEController.text));

    _recoverVerifyOtpInProgress = false;
    setState(() {});
    if (networkResponse.isSuccess) {
      snackBarMessage(context, networkResponse.responseBody['data']);
    } else {
      snackBarMessage(context, networkResponse.errorMessage, true);
    }
  }

  void _onTapSingInScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SingInScreen()),
        (_) => false);
  }
}
