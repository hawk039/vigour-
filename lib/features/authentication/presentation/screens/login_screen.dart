import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import '../widgets/login_social.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: Stack(
          children: [
            // Decorative background blurs
            Positioned(
              top: -100.h,
              right: -100.w,
              child: Container(
                width: 300.w,
                height: 300.w,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 400.h,
              left: -150.w,
              child: Container(
                width: 300.w,
                height: 300.w,
                decoration: BoxDecoration(
                  color: AppTheme.dustyRose.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      // Back Button
                      SizedBox(height: 20.h),
                      const LoginHeader(),
                      SizedBox(height: 40.h),
                      const LoginForm(),
                      SizedBox(height: 32.h),
                      // Community Link
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).canPop()
                                ? Navigator.of(context).pop()
                                : Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const SignupScreen(),
                                    ),
                                  );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: AppTheme.navyDeep.withValues(alpha: 0.5),
                                fontSize: 12.sp,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Signup',
                                  style: TextStyle(
                                    color: AppTheme.navyDeep,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom Indicator
            Positioned(
              bottom: 8.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 130.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
