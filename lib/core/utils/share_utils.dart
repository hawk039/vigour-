import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../features/home/domain/models/quote.dart';
import '../../features/home/presentation/widgets/explore_card.dart';

class ShareUtils {
  static final ScreenshotController _screenshotController = ScreenshotController();

  static Future<void> shareQuote(BuildContext context, Quote quote, bool isLiked) async {
    try {
      // Capture the widget as an image
      final uint8list = await _screenshotController.captureFromWidget(
        MediaQuery(
          data: MediaQuery.of(context),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Material(
              child: ExploreCard(
                quote: quote,
                isLiked: isLiked,
              ),
            ),
          ),
        ),
        delay: const Duration(milliseconds: 100),
      );

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/quote_share.png').create();
      await imagePath.writeAsBytes(uint8list);

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: 'Check out this quote from Vigour: "${quote.text}" - ${quote.author}',
      );
    } catch (e) {
      debugPrint("Error sharing quote: $e");
    }
  }
}
