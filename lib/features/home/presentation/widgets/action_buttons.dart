import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../../../core/utils/share_utils.dart';
import '../../domain/models/quote.dart';
import '../view_models/home_view_model.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final quote = viewModel.currentQuote;
    final isLiked = viewModel.favoriteQuotes.any((q) => q.text == quote.text);
    
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildActionButton(
            icon: isLiked ? Icons.favorite : Icons.favorite_border,
            label: 'SAVE',
            color: isLiked ? AppTheme.roseGold : AppTheme.pastelCoral,
            size: 70.w,
            iconSize: 32.sp,
            isFilled: true,
            onTap: () => viewModel.saveQuote(),
          ),
          SizedBox(width: 48.w),
          _buildActionButton(
            icon: Icons.send,
            label: 'SHARE',
            color: AppTheme.pastelPearl,
            size: 50.w,
            onTap: () {
              ShareUtils.shareQuote(context, quote, isLiked);
              viewModel.addSharedQuote(quote);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required double size,
    double iconSize = 24,
    bool isFilled = false,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(size * 0.4),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 15.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: (iconSize == 24) ? 22.sp : iconSize,
              color: isFilled ? Colors.white : AppTheme.charcoalDeep,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.navyDeep.withOpacity(0.4),
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.w,
          ),
        ),
      ],
    );
  }
}
