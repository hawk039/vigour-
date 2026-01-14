import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../view_models/home_view_model.dart';
import 'quote_card.dart';
import 'action_buttons.dart';

class QuoteOfTheDayView extends StatelessWidget {
  const QuoteOfTheDayView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuoteCard(quote: viewModel.currentQuote),
                SizedBox(height: 24.h),
                const ActionButtons(),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
