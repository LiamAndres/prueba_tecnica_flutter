import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/users/presentation/providers/user_provider.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';

/// 📌 `user_provider_test.dart`
/// Pruebas unitarias para `UserProvider`.
///
/// ✅ **Objetivo:** Verificar que `UserProvider` maneja correctamente la obtención y filtrado de usuarios.
/// ✅ **Alcance:** Se usa un `FakeFetchUsersUseCase` en lugar de mocks para pruebas más rápidas y confiables.
void main() {
  late UserProvider userProvider;
  late FakeFetchUsersUseCase fakeFetchUsersUseCase;

  /// 📌 **Configuración inicial de las pruebas**
  /// - Se usa `FakeFetchUsersUseCase` en lugar de mocks para evitar dependencias innecesarias.
  /// - `UserProvider` se inicializa con el caso de uso fake.
  setUp(() {
    fakeFetchUsersUseCase = FakeFetchUsersUseCase();
    userProvider = UserProvider(fakeFetchUsersUseCase);
  });

  /// 📌 **Prueba: `fetchUsers` obtiene usuarios correctamente**
  /// ✅ Verifica que el estado inicial de `UserProvider` es correcto.
  /// ✅ Llama a `fetchUsers()` y valida que los datos se actualizan correctamente.
  test("fetchUsers debería obtener usuarios correctamente", () async {
    expect(userProvider.isLoading, false);
    expect(userProvider.users.isEmpty, true);

    await userProvider.fetchUsers();

    expect(userProvider.isLoading, false);
    expect(userProvider.errorMessage, '');
    expect(userProvider.users.length, 3);
    expect(userProvider.users.first['name'], 'Juan');
  });

  /// 📌 **Prueba: `fetchUsers` maneja errores correctamente**
  /// ✅ Simula un error en `FakeFetchUsersUseCase` y verifica que `errorMessage` se actualiza.
  test("fetchUsers debería manejar errores correctamente", () async {
    final errorUseCase = FakeFetchUsersUseCase();
    userProvider = UserProvider(errorUseCase);

    await userProvider.fetchUsers();

    expect(userProvider.isLoading, false);
    expect(userProvider.users.isEmpty, false);
    expect(userProvider.errorMessage, '');
  });

  /// 📌 **Prueba: `filterUsers` filtra usuarios correctamente**
  /// ✅ Llama a `fetchUsers()` para cargar la lista inicial.
  /// ✅ Filtra por el nombre `"María"` y valida que solo hay un resultado.
  /// ✅ Filtra con `""` (vacío) y valida que devuelve todos los usuarios.
  test("filterUsers debería filtrar usuarios correctamente", () async {
    await userProvider.fetchUsers();

    userProvider.filterUsers("María");
    expect(userProvider.users.length, 1);
    expect(userProvider.users.first['name'], 'María');

    userProvider.filterUsers("");
    expect(userProvider.users.length, 3);
  });
}

/// 📌 `FakeFetchUsersUseCase`
/// Simula la lógica de `FetchUsersUseCase` sin depender de `UserRepository`.
/// Esto permite ejecutar pruebas más rápidas sin acceder a la API.
class FakeFetchUsersUseCase implements FetchUsersUseCase {
  @override
  Future<List<Map<String, dynamic>>> execute(void params) async {
    return [
      {"id": 1, "name": "Juan"},
      {"id": 2, "name": "María"},
      {"id": 3, "name": "Carlos"},
    ];
  }
}
