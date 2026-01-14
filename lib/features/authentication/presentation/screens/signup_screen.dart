import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme.dart';
import '../widgets/signup_form.dart';
import '../widgets/signup_header.dart';
import '../widgets/signup_social.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppTheme.backgroundGradient,
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      SizedBox(height: 30.h),
                      const SignupHeader(),
                      SizedBox(height: 30.h),
                      const SignupForm(),
                      SizedBox(height: 50.h),
                      const SignupSocial(),
                      SizedBox(height: 20.h),
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
