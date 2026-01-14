import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: GoogleFonts.playfairDisplay(
            color: AppTheme.navyDeep,
            fontSize: 40.sp,
            height: 1.2,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Continue your journey of inspiration',
          style: TextStyle(
            color: AppTheme.navyDeep.withValues(alpha: 0.5),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
