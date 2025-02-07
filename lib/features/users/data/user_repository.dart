import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

/// 📌 `UserRepository`
/// Responsable de manejar la obtención y almacenamiento de usuarios.
///
/// 🔹 **Propósito**:
///   - Obtiene la lista de usuarios desde la API.
///   - Almacena los usuarios en **Hive** para uso sin conexión.
///   - Si los datos ya están en Hive, los obtiene sin llamar a la API.
///
/// 🔹 **Dependencias**:
///   - `Dio`: Para realizar solicitudes HTTP a la API.
///   - `Hive`: Para almacenamiento local de usuarios.
///
/// 🔹 **Métodos**:
///   - `fetchUsers()`:
///     - Consulta la API para obtener usuarios.
///     - Guarda los usuarios en Hive si no están almacenados.
///     - Si los datos ya existen en Hive, los devuelve sin llamar a la API.
class UserRepository {
  /// 📌 Cliente HTTP para realizar solicitudes a la API.
  final Dio dio;

  /// 📌 Nombre de la caja en Hive donde se almacenarán los usuarios.
  final String _boxName = 'usersBox';

  /// 📌 Constructor
  /// - Permite inyectar una instancia de `Dio` (útil para pruebas).
  /// - Si no se proporciona, crea una instancia con la URL base.
  UserRepository({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com"));

  /// 📌 Obtiene la lista de usuarios.
  ///
  /// 🔹 **Flujo de trabajo**:
  ///   1️⃣ Verifica si los usuarios ya están en **Hive**.
  ///   2️⃣ Si existen, los devuelve sin llamar a la API.
  ///   3️⃣ Si no existen, consulta la API, almacena los datos y los devuelve.
  ///
  /// 🔹 **Manejo de errores**:
  ///   - Si la API falla, lanza una excepción.
  Future<List<dynamic>> fetchUsers() async {
    try {
      var box = await Hive.openBox(_boxName);

      // 📌 1️⃣ Si los usuarios ya están en Hive, los devolvemos.
      if (box.isNotEmpty) {
        return box.values.map((e) => Map<String, dynamic>.from(e)).toList();
      }

      // 📌 2️⃣ Si no están en Hive, consultamos la API.
      final response = await dio.get("/users");
      final users = response.data;

      // 📌 3️⃣ Guardamos los usuarios en Hive con claves únicas (ID).
      await box.putAll(
        {for (var user in users) user['id']: user},
      );

      return users;
    } catch (e) {
      throw Exception("Error al obtener usuarios: $e");
    }
  }
}
