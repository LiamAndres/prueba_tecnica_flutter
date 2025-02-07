import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';
import 'package:prueba_tecnica_flutter/features/users/data/user_repository.dart';
import 'fetch_users_usecase_test.mocks.dart';

/// 📌 `fetch_users_usecase_test.dart`
/// Pruebas unitarias para `FetchUsersUseCase`.
///
/// ✅ **Objetivo:** Validar que `FetchUsersUseCase` llama correctamente al repositorio y maneja errores.
/// ✅ **Alcance:** Se usa `MockUserRepository` generado con `Mockito` para simular respuestas.

/// 🔹 Genera un Mock de `UserRepository` para evitar llamadas reales a la API.
@GenerateMocks([UserRepository])
void main() {
  late FetchUsersUseCase fetchUsersUseCase;
  late MockUserRepository mockUserRepository;

  /// 📌 **Configuración inicial de las pruebas**
  /// - Se instancia `MockUserRepository` para evitar llamadas reales.
  /// - Se inyecta en `FetchUsersUseCase`.
  setUp(() {
    mockUserRepository = MockUserRepository();
    fetchUsersUseCase = FetchUsersUseCase(mockUserRepository);
  });

  /// 📌 **Prueba: `execute` obtiene la lista de usuarios correctamente**
  /// ✅ Simula que el repositorio devuelve una lista de usuarios.
  /// ✅ Verifica que `fetchUsersUseCase.execute(null)` devuelve los datos esperados.
  /// ✅ Verifica que `fetchUsers()` fue llamado exactamente una vez.
  test("Debería obtener la lista de usuarios correctamente", () async {
    // 🔹 Datos simulados que devolverá el mock
    final fakeUsers = [
      {"id": 1, "name": "Usuario 1"},
      {"id": 2, "name": "Usuario 2"},
    ];

    when(mockUserRepository.fetchUsers()).thenAnswer((_) async => fakeUsers);

    // 🔹 Ejecutamos el caso de uso
    final result = await fetchUsersUseCase.execute(null);

    // 🔹 Verificamos que se llamara correctamente al repositorio
    verify(mockUserRepository.fetchUsers()).called(1);

    // 🔹 Verificamos que los datos sean los esperados
    expect(result, equals(fakeUsers));
  });

  /// 📌 **Prueba: `execute` lanza una excepción cuando el repositorio falla**
  /// ✅ Simula que el repositorio lanza un error.
  /// ✅ Verifica que `fetchUsersUseCase.execute(null)` lanza una excepción.
  test("Debería lanzar una excepción cuando el repositorio falla", () async {
    when(mockUserRepository.fetchUsers())
        .thenThrow(Exception("Error en la API"));

    expect(fetchUsersUseCase.execute(null), throwsException);
  });
}
