import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';

class ResetPasswordHeader extends StatelessWidget {
  const ResetPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Reset Your Password',
          textAlign: TextAlign.center,
          style:  GoogleFonts.playfairDisplay(
            color: AppTheme.navyDeep,
            fontSize: 40.sp,
            height: 1.2,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Enter your email to receive a reset link',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.navyDeep.withValues(alpha: 0.6),
              fontSize: 14.sp,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
