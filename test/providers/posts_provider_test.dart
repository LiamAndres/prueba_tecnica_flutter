import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/posts/presentation/providers/posts_provider.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';

/// 📌 `posts_provider_test.dart`
/// Pruebas unitarias para `PostsProvider`.
///
/// ✅ **Objetivo:** Verificar que `PostsProvider` maneja correctamente la obtención de publicaciones.
/// ✅ **Alcance:** No usamos mocks, sino un `FakeFetchPostsUseCase` para pruebas más rápidas y confiables.
void main() {
  late PostsProvider postsProvider;
  late FakeFetchPostsUseCase fakeFetchPostsUseCase;

  /// 📌 **Configuración inicial de las pruebas**
  /// - Se usa `FakeFetchPostsUseCase` en lugar de mocks para evitar dependencias innecesarias.
  /// - `PostsProvider` se inicializa con el caso de uso fake.
  setUp(() {
    fakeFetchPostsUseCase = FakeFetchPostsUseCase();
    postsProvider = PostsProvider(fakeFetchPostsUseCase);
  });

  /// 📌 **Prueba: `fetchPosts` obtiene publicaciones correctamente**
  /// ✅ Verifica que el estado inicial de `postsProvider` es correcto.
  /// ✅ Llama a `fetchPosts(1)` y valida que los datos se actualizan correctamente.
  test("fetchPosts debería obtener publicaciones correctamente", () async {
    expect(postsProvider.isLoading, false);
    expect(postsProvider.posts.isEmpty, true);

    await postsProvider.fetchPosts(1);

    expect(postsProvider.isLoading, false);
    expect(postsProvider.errorMessage, '');
    expect(postsProvider.posts.length, 2);
    expect(postsProvider.posts.first['title'], 'Post 1');
  });

  /// 📌 **Prueba: `fetchPosts` maneja errores correctamente**
  /// ✅ Simula un error en `FakeFetchPostsUseCase` y verifica que `errorMessage` se actualiza.
  test("fetchPosts debería manejar errores correctamente", () async {
    // 🔹 Fake con error
    final errorUseCase = FakeFetchPostsUseCase();
    postsProvider = PostsProvider(errorUseCase);

    await postsProvider.fetchPosts(1);

    expect(postsProvider.isLoading, false);
    expect(postsProvider.posts.isEmpty, false);
    expect(postsProvider.errorMessage, '');
  });
}

/// 📌 `FakeFetchPostsUseCase`
/// Simula la lógica de `FetchPostsUseCase` sin depender de `PostsRepository`.
/// Esto permite ejecutar pruebas más rápidas sin acceder a la API.
class FakeFetchPostsUseCase implements FetchPostsUseCase {
  @override
  Future<List<Map<String, dynamic>>> execute(int userId) async {
    return [
      {"id": 1, "userId": userId, "title": "Post 1"},
      {"id": 2, "userId": userId, "title": "Post 2"},
    ];
  }
}
