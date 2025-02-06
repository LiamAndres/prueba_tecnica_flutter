import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class UserRepository {
  final Dio dio; // 🔹 Hacemos que `Dio` se pase por el constructor
  final String _boxName = 'usersBox';

  UserRepository({Dio? dio}) : dio = dio ?? Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future<List<dynamic>> fetchUsers() async {
    try {
      var box = await Hive.openBox(_boxName);

      if (box.isNotEmpty) {
        return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
      }

      final response = await dio.get("/users");
      final users = response.data;

      await box.putAll(
        {for (var user in users) user['id']: user}, // ✅ Guardamos con clave única
      );

      return users;
    } catch (e) {
      throw Exception("Error al obtener usuarios: $e");
    }
  }
}
