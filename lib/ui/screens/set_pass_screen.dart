import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';

class SetPassScreen extends StatefulWidget {
  const SetPassScreen({super.key});

  @override
  State<SetPassScreen> createState() => _SetPassScreenState();
}

class _SetPassScreenState extends State<SetPassScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _obscureText = true;

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
            'Set Your\nPassword!',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Minimum length password 8 character with Latter and number combination',
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildOTPEmailForm() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          const SizedBox(height: 44),
          TextFormField(
            controller: _newPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'New password',
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
          const SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Confirm password',
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
          ElevatedButton(
            onPressed: _onTapConfirmButton,
            child: const Text('CONFIRM'),
          ),
        ],
      ),
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

  void _onTapConfirmButton() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SingInScreen(),
      ),
    );
  }

  void _onTapSingInScreen() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SingInScreen()),
            (_) => false);
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
