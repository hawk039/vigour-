import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../domain/models/quote.dart';
import '../view_models/home_view_model.dart';

class SharedHistoryView extends StatelessWidget {
  const SharedHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.sharedQuotes.isEmpty) {
          return Center(
            child: Text(
              'No shared quotes yet',
              style: TextStyle(
                color: AppTheme.navyDeep.withOpacity(0.4),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          physics: const BouncingScrollPhysics(),
          itemCount: viewModel.sharedQuotes.length,
          itemBuilder: (context, index) {
            final quote = viewModel.sharedQuotes[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (index == 0) _buildSectionHeader('History'),
                _buildSharedCard(quote),
                if (index == viewModel.sharedQuotes.length - 1) SizedBox(height: 20.h),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 8.h, left: 8.w),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: AppTheme.navyDeep.withOpacity(0.4),
          fontSize: 9.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.w,
        ),
      ),
    );
  }

  Widget _buildSharedCard(SharedQuote quote) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        quote.shareType,
                        size: 14.sp,
                        color: AppTheme.navyDeep.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      quote.shareTime,
                      style: TextStyle(
                        color: AppTheme.navyDeep.withOpacity(0.5),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  '"${quote.text}"',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.playfairDisplay(
                    color: AppTheme.charcoalDeep,
                    fontSize: 18.sp,
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.only(top: 12.h),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.2)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '— ${quote.author.toUpperCase()}',
                        style: TextStyle(
                          color: AppTheme.navyDeep.withOpacity(0.4),
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.w,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 16.sp,
                            color: quote.isLiked ? AppTheme.pastelCoral : AppTheme.navyDeep.withOpacity(0.3),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.chat_bubble,
                            size: 16.sp,
                            color: AppTheme.navyDeep.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
