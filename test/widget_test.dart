import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/main.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';
import 'package:prueba_tecnica_flutter/features/posts/data/posts_repository.dart';
import 'package:prueba_tecnica_flutter/features/users/data/user_repository.dart';

void main() {
  testWidgets('La aplicación se construye sin errores', (WidgetTester tester) async {
    // ✅ Creamos instancias simuladas de los casos de uso
    final fetchPostsUseCase = FetchPostsUseCase(PostsRepository());
    final fetchUsersUseCase = FetchUsersUseCase(UserRepository());

    // ✅ Pasamos las instancias al MyApp
    await tester.pumpWidget(MyApp(
      fetchPostsUseCase: fetchPostsUseCase,
      fetchUsersUseCase: fetchUsersUseCase,
    ));

    // ✅ Verificamos que la app se muestra correctamente
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
