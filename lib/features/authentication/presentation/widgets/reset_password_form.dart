import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../view_models/reset_password_view_model.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(40.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
            child: Text(
              'EMAIL ADDRESS',
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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: AppTheme.navyDeep, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: 'hello@example.com',
                hintStyle: TextStyle(
                  color: AppTheme.navyDeep.withValues(alpha: 0.3),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Consumer<ResetPasswordViewModel>(
            builder: (context, viewModel, child) {
              return GestureDetector(
                onTap: viewModel.isLoading
                    ? null
                    : () => viewModel.sendResetLink(_emailController.text),
                child: Container(
                  height: 60.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.pastelAmber,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.pastelPearl.withValues(alpha: 0.6),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: viewModel.isLoading
                      ? const CircularProgressIndicator(
                          color: AppTheme.navyDeep,
                        )
                      : Text(
                          'SEND RESET LINK',
                          style: TextStyle(
                            color: AppTheme.navyDeep,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 12.sp,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
