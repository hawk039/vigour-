import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vigour/features/authentication/presentation/screens/reset_password_screen.dart';
import '../../../../core/theme.dart';
import '../view_models/login_view_model.dart';
import 'login_social.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final viewModel = context.read<LoginViewModel>();
    
    final success = await viewModel.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage ?? 'Login failed. Please check your credentials.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
       // On success, the AuthGate in main.dart will automatically switch to HomeScreen.
       // We can pop the Login screen if it was pushed on top of Signup.
       if (Navigator.canPop(context)) {
         Navigator.pop(context);
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField(
            label: 'EMAIL ADDRESS',
            hint: 'hello@example.com',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 24.h),
          _buildInputField(
            label: 'PASSWORD',
            hint: '••••••••',
            controller: _passwordController,
            obscureText: true,
          ),
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ResetPasswordScreen(),
                  ),
                );
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: AppTheme.navyDeep.withValues(alpha: 0.6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Consumer<LoginViewModel>(
            builder: (context, viewModel, child) {
              return GestureDetector(
                onTap: viewModel.isLoading ? null : _handleLogin,
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.pastelAmber,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.pastelAmber.withValues(alpha: 0.6),
                        blurRadius: 25,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(
                          color: AppTheme.charcoalDeep,
                        )
                      : Text(
                          'LOGIN',
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
          SizedBox(height: 40.h),
          const LoginSocial(),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
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
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: TextStyle(color: AppTheme.navyDeep, fontSize: 14.sp),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppTheme.navyDeep.withValues(alpha: 0.3),
                fontSize: 14.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
