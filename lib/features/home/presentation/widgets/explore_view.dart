import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../../../core/utils/share_utils.dart';
import '../view_models/home_view_model.dart';
import 'explore_card.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final viewModel = context.read<HomeViewModel>();
      if (!viewModel.isFeedLoading) {
        viewModel.loadMoreFeed();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header (Explore + Avatar)
        Padding(
          padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore',
                style: TextStyle(
                  color: AppTheme.navyDeep.withOpacity(0.8),
                  fontSize: 24.sp,
                  fontFamily: 'Playfair Display',
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=800&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                SizedBox(width: 16.w),
                Icon(Icons.search, color: AppTheme.navyDeep.withOpacity(0.4), size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search keyword or author...',
                      hintStyle: TextStyle(
                        color: AppTheme.navyDeep.withOpacity(0.3),
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Categories
        SizedBox(
          height: 36.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildCategoryChip(context, 'All Feed'),
              _buildCategoryChip(context, 'Motivation'),
              _buildCategoryChip(context, 'Wisdom'),
              _buildCategoryChip(context, 'Zen'),
              _buildCategoryChip(context, 'Mindfulness'),
              _buildCategoryChip(context, 'Reflection'),
              _buildCategoryChip(context, 'Inspiration'),
            ],
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Feed
        Expanded(
          child: Consumer<HomeViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.isFeedLoading && viewModel.feedQuotes.isEmpty) {
                return const Center(child: CircularProgressIndicator(color: AppTheme.pastelCoral));
              }

              if (viewModel.feedQuotes.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No quotes found.',
                        style: TextStyle(color: AppTheme.navyDeep.withOpacity(0.5)),
                      ),
                      TextButton(
                        onPressed: () => viewModel.refreshFeed(),
                        child: const Text('Tap to refresh'),
                      ),
                    ],
                  ),
                );
              }
              
              return RefreshIndicator(
                onRefresh: () => viewModel.refreshFeed(),
                color: AppTheme.pastelCoral,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: viewModel.feedQuotes.length + (viewModel.isFeedLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == viewModel.feedQuotes.length) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: const Center(child: CircularProgressIndicator(color: AppTheme.pastelCoral)),
                      );
                    }

                    final quote = viewModel.feedQuotes[index];
                    final isLiked = viewModel.favoriteQuotes.any((q) => q.text == quote.text);
                    
                    return ExploreCard(
                      key: ValueKey(quote.text + index.toString()),
                      quote: quote,
                      isLiked: isLiked,
                      onLike: () => viewModel.toggleFavorite(quote),
                      onShare: () {
                        ShareUtils.shareQuote(context, quote, isLiked);
                        viewModel.addSharedQuote(quote);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, String label) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    final isActive = viewModel.selectedCategory == label;

    return GestureDetector(
      onTap: () => viewModel.setCategory(label),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.navyDeep : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20.r),
          border: isActive ? null : Border.all(color: Colors.white.withOpacity(0.3)),
        ),
        alignment: Alignment.center,
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isActive ? Colors.white : AppTheme.navyDeep.withOpacity(0.6),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.w,
          ),
        ),
      ),
    );
  }
}
