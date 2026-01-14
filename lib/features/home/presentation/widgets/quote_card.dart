import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../domain/models/quote.dart';
import '../view_models/home_view_model.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<HomeViewModel>().isLoading;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 320.h,
          maxHeight: 450.h, 
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.r),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navyDeep.withValues(alpha: 0.15),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: isLoading 
            ? Container(
                color: AppTheme.lavenderSoft.withValues(alpha: 0.3),
                child: const Center(child: CircularProgressIndicator(color: AppTheme.pastelCoral)),
              )
            : Stack(
                children: [
                  // Premium Textured Background
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.lavenderSoft,
                            AppTheme.dustyRose.withValues(alpha: 0.8),
                            AppTheme.pastelPearl.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Decorative Texture elements
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _PremiumTexturePainter(),
                    ),
                  ),

                  // Subtle Mesh-like glow
                  Positioned(
                    top: -100,
                    left: -50,
                    child: Container(
                      width: 300.w,
                      height: 300.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Themed Glossy Overlay
                  Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(40.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.02),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_quote,
                                color: AppTheme.navyDeep.withValues(alpha: 0.3),
                                size: 32.sp,
                              ),
                              SizedBox(height: 12.h),
                              Flexible(
                                child: Text(
                                  '"${quote.text}"',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.playfairDisplay(
                                    color: AppTheme.navyDeep,
                                    fontSize: 26.sp,
                                    height: 1.2,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Container(
                                height: 1.h,
                                width: 40.w,
                                color: AppTheme.navyDeep.withValues(alpha: 0.2),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                '— ${quote.author.toUpperCase()}',
                                style: TextStyle(
                                  color: AppTheme.navyDeep.withValues(alpha: 0.6),
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.w,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppTheme.pastelCoral.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
                              ),
                              child: Text(
                                quote.category.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _PremiumTexturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 0.5;

    final random = Random(42);
    
    // Draw subtle dots
    for (int i = 0; i < 800; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.6, paint);
    }

    // Draw some subtle curved lines
    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < 5; i++) {
      final path = Path();
      path.moveTo(0, random.nextDouble() * size.height);
      path.quadraticBezierTo(
        size.width / 2, 
        random.nextDouble() * size.height, 
        size.width, 
        random.nextDouble() * size.height
      );
      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
