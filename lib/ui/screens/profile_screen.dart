import 'package:flutter/material.dart';
import 'package:task_manager_mobile_app/ui/utils/app_colors.dart';
import 'package:task_manager_mobile_app/ui/widgets/screen_background.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _obscureText = true;

  final String _imageUrl = '';

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
              _buildProfileUpdateForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Update\nProfile!',
            style: textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
          ),
          Stack(alignment: const Alignment(0, 1.8), children: [
            CircleAvatar(
              backgroundColor: AppColors.foregroundColor,
              maxRadius: 56,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: ClipOval(
                  child: _imageUrl.isNotEmpty
                      ? Image.network(
                          _imageUrl,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          Icons.person,
                          size: 56,
                          color: AppColors.backgroundColor,
                        ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: Colors.white,
                backgroundColor: AppColors.backgroundColor.withOpacity(0.9),
              ),
              onPressed: () {},
              child: const Text('Edit'),
            ),
          ])
        ],
      ),
    );
  }

  Widget _buildProfileUpdateForm() {
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
            onPressed: _onTapSaveButton,
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _onTapSaveButton() {
    if (!_globalKey.currentState!.validate()) {
      return;
    }
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
