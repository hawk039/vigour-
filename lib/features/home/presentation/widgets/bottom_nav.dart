import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../domain/models/quote.dart';
import '../view_models/home_view_model.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Container(
      padding: EdgeInsets.fromLTRB(40.w, 16.h, 40.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            icon: Icons.grid_view,
            label: 'DAILY',
            isActive: viewModel.currentTab == HomeTab.daily,
            onTap: () => viewModel.setTab(HomeTab.daily),
          ),
          _buildNavItem(
            icon: Icons.explore_outlined,
            label: 'EXPLORE',
            isActive: viewModel.currentTab == HomeTab.explore,
            onTap: () => viewModel.setTab(HomeTab.explore),
          ),
          _buildNavItem(
            icon: Icons.favorite_border,
            label: 'FAVOURITES',
            isActive: viewModel.currentTab == HomeTab.favorites,
            onTap: () => viewModel.setTab(HomeTab.favorites),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final color = isActive ? AppTheme.pastelCoral : AppTheme.navyDeep;
    final opacity = isActive ? 1.0 : 0.3;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: opacity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive && label == 'FAVOURITES' ? Icons.favorite : icon,
              color: isActive ? AppTheme.roseGold : AppTheme.navyDeep,
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppTheme.charcoalDeep : AppTheme.navyDeep,
                fontSize: 9.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
