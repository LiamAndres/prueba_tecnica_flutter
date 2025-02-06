import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';
import 'package:prueba_tecnica_flutter/features/users/data/user_repository.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:io';
import 'package:dio/dio.dart';

// 🔹 Mock de Dio para evitar llamadas reales a la API
class MockDio extends Mock implements Dio {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // 🔹 Creamos un directorio temporal para Hive (sin path_provider)
  final Directory tempDir = Directory.systemTemp;
  Hive.init(tempDir.path);

  late FetchUsersUseCase fetchUsersUseCase;
  late UserRepository userRepository;
  late MockDio mockDio;

  setUp(() async {
    await Hive.deleteFromDisk(); // Limpia Hive antes de cada prueba
    mockDio = MockDio(); // Creamos la instancia mock de Dio
    userRepository = UserRepository(dio: mockDio); // ✅ Inyectamos `mockDio`
    fetchUsersUseCase = FetchUsersUseCase(userRepository);
  });

  test("fetchUsers debería obtener datos desde la API", () async {
    // 🔹 Simulamos una respuesta exitosa de la API
    when(() => mockDio.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: "/users"),
        statusCode: 200,
        data: [
          {"id": 1, "name": "Usuario 1"},
          {"id": 2, "name": "Usuario 2"},
        ],
      ),
    );

    final users = await fetchUsersUseCase.execute(null);

    expect(users.isNotEmpty, true);
    expect(users.length, equals(2));
    expect(users.first["name"], "Usuario 1");
  });

  test("fetchUsers debería obtener datos desde Hive si ya existen", () async {
    final box = await Hive.openBox('usersBox');

    await box.putAll({
      1: {"id": 1, "name": "Usuario Prueba"},
    });

    final users = await fetchUsersUseCase.execute(null);

    expect(users.length, 1);
    expect(users.first["name"], "Usuario Prueba");
  });

  test("fetchUsers debería manejar errores de la API correctamente", () async {
    // 🔹 Simulamos un error 500 en la API
    when(() => mockDio.get(any())).thenThrow(DioException(
      requestOptions: RequestOptions(path: "/users"),
      response: Response(
        requestOptions: RequestOptions(path: "/users"),
        statusCode: 500,
        data: {"error": "Internal Server Error"},
      ),
      type: DioExceptionType.badResponse,
    ));

    expect(fetchUsersUseCase.execute(null), throwsException);
  });
}
