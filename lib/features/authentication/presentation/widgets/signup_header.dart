import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome',
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
          'BEGIN YOUR JOURNEY',
          style: TextStyle(
            color: AppTheme.navyDeep.withValues(alpha: 0.5),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
