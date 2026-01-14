import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../domain/models/quote.dart';
import '../view_models/home_view_model.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/explore_view.dart';
import '../widgets/home_header.dart';
import '../widgets/quote_of_the_day_view.dart';
import '../widgets/shared_history_view.dart';
import 'favorites_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final decoration = viewModel.currentTab == HomeTab.favorites 
            ? AppTheme.twilightGradient 
            : AppTheme.backgroundGradient;

        return Scaffold(
          body: Container(
            decoration: decoration,
            child: Stack(
              children: [
                if (viewModel.currentTab == HomeTab.daily) _buildBackgroundBlurs(),
                SafeArea(
                  bottom: false,
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600.w),
                      child: Column(
                        children: [
                          if (viewModel.currentTab != HomeTab.explore) const HomeHeader(),
                          Expanded(
                            child: _buildBody(viewModel),
                          ),
                          const BottomNav(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(HomeViewModel viewModel) {
    switch (viewModel.currentTab) {
      case HomeTab.explore:
        return const ExploreView();
      case HomeTab.favorites:
        return const FavoritesView();
      case HomeTab.daily:
        return const QuoteOfTheDayView();
      case HomeTab.history:
        return const SharedHistoryView();
      default:
        return const QuoteOfTheDayView();
    }
  }

  Widget _buildBackgroundBlurs() {
    return Positioned(
      top: -100.h,
      right: -100.w,
      child: Container(
        width: 300.w,
        height: 300.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }
}
