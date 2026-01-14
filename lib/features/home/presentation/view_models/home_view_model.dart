import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/repositories/quote_repository.dart';
import '../../domain/models/quote.dart';

class HomeViewModel extends ChangeNotifier {
  final QuoteRepository _repository;
  
  HomeViewModel({required QuoteRepository repository}) : _repository = repository {
    _loadFavorites();
    _initQuoteOfTheDay();
    _fetchFeed();
  }

  HomeTab _currentTab = HomeTab.daily;
  HomeTab get currentTab => _currentTab;

  String _selectedCategory = 'All Feed';
  String get selectedCategory => _selectedCategory;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isFeedLoading = false;
  bool get isFeedLoading => _isFeedLoading;

  final List<Quote> _feedQuotes = [];
  List<Quote> get feedQuotes => _feedQuotes;

  Quote? _currentQuote;
  Quote get currentQuote => _currentQuote ?? Quote(
    text: "Your vision will become clear only when you can look into your own heart.",
    author: "Carl Jung",
    category: "REFLECTION",
    imageUrl: 'https://images.unsplash.com/photo-1501854140801-50d01698950b?auto=format&fit=crop&w=800&q=80',
  );

  void setTab(HomeTab tab) {
    if (_currentTab == tab) return;
    _currentTab = tab;
    notifyListeners();
  }

  void setCategory(String category) {
    if (_selectedCategory == category) return;
    _selectedCategory = category;
    refreshFeed();
  }

  Future<void> _initQuoteOfTheDay() async {
    _isLoading = true;
    notifyListeners();
    _currentQuote = await _repository.getRandomQuote();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _fetchFeed() async {
    if (_isFeedLoading) return;
    _isFeedLoading = true;
    notifyListeners();

    try {
      final categoryToFetch = _selectedCategory == 'All Feed' ? null : _selectedCategory;
      final newQuotes = await _repository.getQuotesBatch(10, category: categoryToFetch);
      _feedQuotes.addAll(newQuotes);
    } catch (e) {
      debugPrint("Error fetching feed: $e");
    } finally {
      _isFeedLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreFeed() async {
    await _fetchFeed();
  }

  Future<void> refreshFeed() async {
    _feedQuotes.clear();
    await _fetchFeed();
  }

  List<Quote> _favoriteQuotes = [];
  List<Quote> get favoriteQuotes => _favoriteQuotes;

  Future<void> _loadFavorites() async {
    _favoriteQuotes = await _repository.getFavorites();
    notifyListeners();
  }

  void toggleFavorite(Quote quote) async {
    final isAlreadyFavorite = _favoriteQuotes.any((q) => q.text == quote.text);
    
    try {
      if (isAlreadyFavorite) {
        await _repository.removeFromFavorites(quote.text);
      } else {
        await _repository.addToFavorites(quote);
      }
      await _loadFavorites();
    } catch (e) {
      debugPrint("Error toggling favorite: $e");
    }
  }

  void saveQuote([Quote? quote]) {
    final targetQuote = quote ?? _currentQuote;
    if (targetQuote != null) {
      toggleFavorite(targetQuote);
    }
  }

  final List<SharedQuote> _sharedQuotes = [];
  List<SharedQuote> get sharedQuotes => _sharedQuotes;

  void addSharedQuote(Quote quote) {
    _sharedQuotes.insert(0, SharedQuote(
      text: quote.text,
      author: quote.author,
      category: quote.category,
      imageUrl: quote.imageUrl,
      shareTime: "Just now",
      shareType: Icons.ios_share,
    ));
    notifyListeners();
  }

  void precachePool(BuildContext context) {
    // Implement precaching logic if needed
  }
}
