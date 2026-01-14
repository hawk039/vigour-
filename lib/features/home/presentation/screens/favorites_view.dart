import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../view_models/home_view_model.dart';
import '../widgets/favorite_quote_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.45)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search saved quotes...',
                    hintStyle: TextStyle(
                      color: AppTheme.darkNavy.withOpacity(0.3),
                      fontSize: 16.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.darkNavy.withOpacity(0.3),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            // Favorites List
            Expanded(
              child: viewModel.favoriteQuotes.isEmpty
                  ? Center(
                      child: Text(
                        'No favorites yet',
                        style: TextStyle(
                          color: AppTheme.navyDeep.withOpacity(0.4),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      physics: const BouncingScrollPhysics(),
                      itemCount: viewModel.favoriteQuotes.length,
                      itemBuilder: (context, index) {
                        final quote = viewModel.favoriteQuotes[index];
                        // Use the imageUrl directly from the quote object
                        // Fallback to a default scenery image if null
                        return FavoriteQuoteCard(
                          quote: quote,
                          imageUrl: quote.imageUrl ??
                              'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80',
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
