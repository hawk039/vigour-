import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../screens/login_screen.dart';
import '../view_models/signup_view_model.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final viewModel = context.read<SignupViewModel>();
    
    final result = await viewModel.signUp(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (result == SignupResult.confirmationRequired) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please check your email for a confirmation link!'),
          backgroundColor: Colors.orangeAccent,
          duration: Duration(seconds: 5),
        ),
      );
    } else if (result == SignupResult.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage ?? 'Signup failed. Please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    // Note: If result == SignupResult.success, AuthGate will handle navigation automatically.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Create Your Account',
              style: TextStyle(
                color: AppTheme.charcoalDeep,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 24.h),
          _buildInputField(
            label: 'FULL NAME',
            hint: 'Jane Doe',
            icon: Icons.person_outline,
            controller: _nameController,
          ),
          SizedBox(height: 16.h),
          _buildInputField(
            label: 'EMAIL ADDRESS',
            hint: 'jane@example.com',
            icon: Icons.mail_outline,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16.h),
          _buildInputField(
            label: 'PASSWORD',
            hint: '••••••••',
            icon: Icons.lock_outline,
            controller: _passwordController,
            obscureText: true,
          ),
          SizedBox(height: 24.h),
          Consumer<SignupViewModel>(
            builder: (context, viewModel, child) {
              return GestureDetector(
                onTap: viewModel.isLoading ? null : _handleSignup,
                child: Container(
                  height: 64.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.coralPeach, Color(0xFFF9D1B5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.coralPeach.withValues(alpha: 0.6),
                        blurRadius: 25,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: viewModel.isLoading
                    ? const CircularProgressIndicator(color: AppTheme.charcoalDeep)
                    : Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: AppTheme.charcoalDeep,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          fontSize: 12.sp,
                        ),
                      ),
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                    color: AppTheme.navyDeep.withValues(alpha: 0.5),
                    fontSize: 11.sp,
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: AppTheme.charcoalDeep,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 6.h),
          child: Text(
            label,
            style: TextStyle(
              color: AppTheme.navyDeep.withValues(alpha: 0.4),
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(color: AppTheme.charcoalDeep, fontSize: 14.sp),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon, 
                color: AppTheme.navyDeep.withValues(alpha: 0.4),
                size: 20.sp,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: AppTheme.charcoalDeep.withValues(alpha: 0.3),
                fontSize: 14.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }
}
