import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class UserRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  Future<List<dynamic>> fetchUsers() async {
    try {
      var box = await Hive.openBox('usersBox');

      if (box.isNotEmpty) {
        return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        final response = await _dio.get("/users");
        final users = response.data;
        for (var user in users) {
          box.add(user);
        }
        return users;
      }
    } catch (e) {
      throw Exception("Error al obtener usuarios");
    }
  }
}
