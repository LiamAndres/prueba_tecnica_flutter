import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/users/presentation/providers/user_provider.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';

// 🔹 Fake del UseCase
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

void main() {
  late UserProvider userProvider;
  late FakeFetchUsersUseCase fakeFetchUsersUseCase;

  setUp(() {
    fakeFetchUsersUseCase = FakeFetchUsersUseCase();
    userProvider = UserProvider(fakeFetchUsersUseCase);
  });

  test("fetchUsers debería obtener usuarios correctamente", () async {
    expect(userProvider.isLoading, false);
    expect(userProvider.users.isEmpty, true);

    await userProvider.fetchUsers();

    expect(userProvider.isLoading, false);
    expect(userProvider.errorMessage, '');
    expect(userProvider.users.length, 3);
    expect(userProvider.users.first['name'], 'Juan');
  });

  test("fetchUsers debería manejar errores correctamente", () async {
    final errorUseCase = FakeFetchUsersUseCase();
    userProvider = UserProvider(errorUseCase);

    await userProvider.fetchUsers();

    expect(userProvider.isLoading, false);
    expect(userProvider.users.isEmpty, false);
    expect(userProvider.errorMessage, '');
  });

  test("filterUsers debería filtrar usuarios correctamente", () async {
    await userProvider.fetchUsers();

    userProvider.filterUsers("María");
    expect(userProvider.users.length, 1);
    expect(userProvider.users.first['name'], 'María');

    userProvider.filterUsers("");
    expect(userProvider.users.length, 3);
  });
}
