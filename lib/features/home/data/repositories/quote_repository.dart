import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/models/quote.dart';

class QuoteRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  // --- Explore / Feed ---

  Future<Quote> getRandomQuote() async {
    try {
      // Use select().limit(1) instead of .single() to avoid PGRST116 if table is empty
      final List<dynamic> response = await _supabase
          .from('quotes')
          .select()
          .limit(1);
      
      if (response.isNotEmpty) {
        final data = response.first;
        return Quote(
          text: data['text'],
          author: data['author'],
          category: data['category'],
          imageUrl: data['image_url'],
        );
      } else {
        debugPrint("getRandomQuote: Table 'quotes' is empty");
      }
    } catch (e) {
      debugPrint("Supabase getRandomQuote Error: $e");
    }
    
    // Fallback quote
    return Quote(
      text: "The best way to predict the future is to create it.",
      author: "Peter Drucker",
      category: "MOTIVATION",
      imageUrl: "https://images.unsplash.com/photo-1501854140801-50d01698950b?auto=format&fit=crop&w=800&q=80",
    );
  }

  Future<List<Quote>> getQuotesBatch(int count, {String? category}) async {
    try {
      debugPrint("Fetching quotes from Supabase... Category Filter: $category");
      
      var query = _supabase.from('quotes').select();
      
      if (category != null && category != 'All Feed') {
        // Ensure exact match with uppercase categories in DB
        query = query.eq('category', category.toUpperCase());
      }

      final List response = await query.limit(count);
      debugPrint("Supabase fetch successful: ${response.length} quotes found");
      
      return response.map((q) => Quote(
        text: q['text'] ?? '',
        author: q['author'] ?? 'Unknown',
        category: q['category'] ?? 'GENERAL',
        imageUrl: q['image_url'],
      )).toList();
    } catch (e) {
      debugPrint("Supabase getQuotesBatch Error: $e");
      return [];
    }
  }

  // --- Favorites ---

  Future<List<Quote>> getFavorites() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      debugPrint("getFavorites: No user logged in");
      return [];
    }

    try {
      final response = await _supabase
          .from('favorites')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return (response as List).map((f) => Quote(
        text: f['text'],
        author: f['author'],
        category: f['category'],
        imageUrl: f['image_url'],
      )).toList();
    } catch (e) {
      debugPrint("Supabase getFavorites Error: $e");
      return [];
    }
  }

  Future<void> addToFavorites(Quote quote) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      await _supabase.from('favorites').insert({
        'user_id': user.id,
        'text': quote.text,
        'author': quote.author,
        'category': quote.category,
        'image_url': quote.imageUrl,
      });
      debugPrint("Quote added to favorites in Supabase");
    } catch (e) {
      debugPrint("Error adding to favorites: $e");
    }
  }

  Future<void> removeFromFavorites(String quoteText) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      await _supabase
          .from('favorites')
          .delete()
          .eq('user_id', user.id)
          .eq('text', quoteText);
      debugPrint("Quote removed from favorites in Supabase");
    } catch (e) {
      debugPrint("Error removing from favorites: $e");
    }
  }
}
