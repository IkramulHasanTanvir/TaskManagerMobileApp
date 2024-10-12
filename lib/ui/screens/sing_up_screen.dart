import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/screens/sing_in_screen.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              _buildSingUpForm(),
              const SizedBox(height: 24),
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
          const SizedBox(height: 24),
          Text(
            'Sing Up',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "hello! let's join with us",
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildSingUpForm() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
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
            controller: _firstNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'First name',
              suffixIcon: Icon(Icons.person_2_outlined),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter valid name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Last name',
              suffixIcon: Icon(Icons.person_2_outlined),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter valid name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              labelText: 'Mobile',
              suffixIcon: Icon(Icons.phone),
            ),
            validator: (String? value) {
              if (value?.isEmpty == true) {
                return 'Enter valid Number';
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onTapSingUpButton,
            child: const Text('SING UP'),
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

  void _onTapSingUpButton() {
    if (!_globalKey.currentState!.validate()) {
      return;
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
