import 'package:flutter/material.dart';
import '../../domain/fetch_posts_usecase.dart';

class PostsProvider with ChangeNotifier {
  final FetchPostsUseCase
      _fetchPostsUseCase; // ✅ Ahora usamos FetchPostsUseCase

  PostsProvider(
      this._fetchPostsUseCase); // ✅ Constructor que recibe FetchPostsUseCase

  List<dynamic> _posts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<dynamic> get posts => _posts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchPosts(int userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _posts = await _fetchPostsUseCase.execute(userId);
    } catch (e) {
      _errorMessage = "Error al obtener publicaciones: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
