import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'quote.g.dart';

enum HomeTab { daily, explore, favorites, history }

@HiveType(typeId: 0)
class Quote extends HiveObject {
  @HiveField(0)
  final String text;
  
  @HiveField(1)
  final String author;
  
  @HiveField(2)
  final String category;
  
  @HiveField(3)
  final String? imageUrl;

  Quote({
    required this.text,
    required this.author,
    required this.category,
    this.imageUrl,
  });
}

class SharedQuote {
  final String text;
  final String author;
  final String category;
  final String? imageUrl;
  final String shareTime;
  final IconData shareType;
  final bool isLiked;

  SharedQuote({
    required this.text,
    required this.author,
    required this.category,
    this.imageUrl,
    required this.shareTime,
    required this.shareType,
    this.isLiked = false,
  });
}
