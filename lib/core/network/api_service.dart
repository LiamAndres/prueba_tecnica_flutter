import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future<List<dynamic>> getUsers() async {
    try {
      final response = await _dio.get("/users");
      return response.data;
    } catch (e) {
      throw Exception("Error al obtener usuarios: $e");
    }
  }

  Future<List<dynamic>> getPostsByUser(int userId) async {
    try {
      final response = await _dio.get("/posts", queryParameters: {"userId": userId});
      return response.data;
    } catch (e) {
      throw Exception("Error al obtener publicaciones: $e");
    }
  }
}
