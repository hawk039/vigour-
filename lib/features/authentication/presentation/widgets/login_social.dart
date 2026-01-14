import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme.dart';

class LoginSocial extends StatelessWidget {
  const LoginSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container(height: 1, color: AppTheme.navyDeep.withValues(alpha: 0.1))),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'SOCIAL LOGIN',
                style: TextStyle(
                  color: AppTheme.navyDeep.withValues(alpha: 0.3),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Expanded(child: Container(height: 1, color: AppTheme.navyDeep.withValues(alpha: 0.1))),
          ],
        ),
        SizedBox(height: 24.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                width: 20.w,
              ),
            ),
            SizedBox(width: 24.w),
            _buildSocialButton(
              child: Icon(Icons.apple, color: AppTheme.navyDeep.withValues(alpha: 0.6), size: 24.sp),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({required Widget child}) {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.3),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
