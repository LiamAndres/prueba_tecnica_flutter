import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';
import 'package:prueba_tecnica_flutter/features/users/data/user_repository.dart';
import 'fetch_users_usecase_test.mocks.dart';

// 🔹 Genera un Mock de UserRepository
@GenerateMocks([UserRepository])
void main() {
  late FetchUsersUseCase fetchUsersUseCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    fetchUsersUseCase = FetchUsersUseCase(mockUserRepository);
  });

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

  test("Debería lanzar una excepción cuando el repositorio falla", () async {
    when(mockUserRepository.fetchUsers()).thenThrow(Exception("Error en la API"));

    expect(fetchUsersUseCase.execute(null), throwsException);
  });
}
