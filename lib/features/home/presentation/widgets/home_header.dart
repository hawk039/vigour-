import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../domain/models/quote.dart';
import '../view_models/home_view_model.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    String title;
    switch (viewModel.currentTab) {
      case HomeTab.favorites:
        title = 'FAVORITES';
        break;
      default:
        title = 'VIGOUR QUOTE OF THE DAY';
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(24.w, 60.h, 24.w, 20.h),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: AppTheme.navyDeep.withOpacity(0.4),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 4.w,
          ),
        ),
      ),
    );
  }
}
