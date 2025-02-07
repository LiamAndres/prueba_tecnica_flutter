import 'package:dio/dio.dart';

/// 📌 `PostsRepository`  
/// Esta clase se encarga de manejar la comunicación con la API para obtener publicaciones.  
/// Utiliza `Dio` para realizar las peticiones HTTP y manejar los datos recibidos.  
class PostsRepository {
  /// Cliente HTTP para realizar las solicitudes a la API.  
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  /// 📌 Obtiene las publicaciones de un usuario desde la API.  
  /// - **Parámetro**: `userId` → ID del usuario cuyas publicaciones queremos obtener.  
  /// - **Devuelve**: Una lista de mapas (`List<Map<String, dynamic>>`) con los datos de las publicaciones.  
  /// - **Manejo de errores**: Captura excepciones y las lanza con un mensaje descriptivo.  
  Future<List<dynamic>> fetchPosts(int userId) async {
    try {
      final response = await _dio.get("/posts", queryParameters: {"userId": userId});
      return List<Map<String, dynamic>>.from(response.data);
    } catch (e) {
      throw Exception("Error al obtener publicaciones: $e");
    }
  }
}
