/* 
📌 ¿Qué hicimos?
✔ Obtenemos las publicaciones del usuario desde la API.
✔ Manejamos isLoading y errorMessage correctamente.
✔ Usamos notifyListeners() para actualizar la UI.

 */

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PostsProvider with ChangeNotifier {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));
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
      final response =
          await _dio.get("/posts", queryParameters: {"userId": userId});
      _posts = response.data;
    } catch (e) {
      _errorMessage = "Error al obtener publicaciones";
    }

    _isLoading = false;
    notifyListeners();
  }
}
