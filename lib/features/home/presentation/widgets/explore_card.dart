import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme.dart';
import '../../domain/models/quote.dart';

class ExploreCard extends StatefulWidget {
  final Quote quote;
  final String? timeAgo;
  final bool isLiked;
  final VoidCallback? onLike;
  final VoidCallback? onShare;

  const ExploreCard({
    super.key,
    required this.quote,
    this.timeAgo,
    this.isLiked = false,
    this.onLike,
    this.onShare,
  });

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> with SingleTickerProviderStateMixin {
  late AnimationController _heartController;
  late Animation<double> _heartAnimation;
  bool _showHeartOverlay = false;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _heartAnimation = CurvedAnimation(
      parent: _heartController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (!widget.isLiked) {
      widget.onLike?.call();
    }
    setState(() => _showHeartOverlay = true);
    _heartController.forward(from: 0).then((_) {
      setState(() => _showHeartOverlay = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _handleDoubleTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        height: 420.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navyDeep.withOpacity(0.15),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            children: [
              // Background Image
              if (widget.quote.imageUrl != null)
                Positioned.fill(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          widget.quote.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.35),
                        ),
                      ),
                    ],
                  ),
                ),

              // Content Overlay
              Container(
                padding: EdgeInsets.all(28.w),
                decoration: BoxDecoration(
                  color: AppTheme.navyDeep.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.25),
                    width: 1.5,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.navyDeep.withOpacity(0.3),
                      AppTheme.navyDeep.withOpacity(0.05),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: Colors.white.withOpacity(0.5),
                      size: 32.sp,
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: Center(
                        child: Text(
                          '"${widget.quote.text}"',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.playfairDisplay(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.h,
                          width: 40.w,
                          color: Colors.white.withOpacity(0.3),
                          margin: EdgeInsets.only(bottom: 20.h),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.quote.author.toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${widget.quote.category}'.toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 8.sp,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Row(
                              children: [
                                _buildCircleButton(
                                  icon: widget.isLiked ? Icons.favorite : Icons.favorite_border,
                                  color: widget.isLiked ? AppTheme.pastelCoral : Colors.white.withOpacity(0.8),
                                  onTap: widget.onLike,
                                ),
                                SizedBox(width: 12.w),
                                _buildCircleButton(
                                  icon: Icons.ios_share,
                                  color: Colors.white.withOpacity(0.8),
                                  onTap: widget.onShare,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Heart Pop Animation Overlay
              if (_showHeartOverlay)
                Center(
                  child: ScaleTransition(
                    scale: _heartAnimation,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white.withOpacity(0.9),
                      size: 100.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircleButton({required IconData icon, Color? color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38.w,
        height: 38.w,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: color,
        ),
      ),
    );
  }
}
