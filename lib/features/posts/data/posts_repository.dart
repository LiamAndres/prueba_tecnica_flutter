import 'package:dio/dio.dart';

class PostsRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future<List<dynamic>> fetchPosts(int userId) async {
    try {
      final response = await _dio.get("/posts", queryParameters: {"userId": userId});
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception("Error al obtener publicaciones: $e");
    }
  }
}
