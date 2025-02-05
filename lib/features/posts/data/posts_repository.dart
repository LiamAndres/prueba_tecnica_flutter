import 'package:dio/dio.dart';

class PostsRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com")); // ✅ Se inicializa Dio aquí

  Future<List<dynamic>> fetchPosts(int userId) async {
    try {
      final response = await _dio.get("/posts", queryParameters: {"userId": userId});
      return response.data; // ✅ Devuelve la lista de publicaciones
    } catch (e) {
      throw Exception("Error al obtener publicaciones");
    }
  }
}
