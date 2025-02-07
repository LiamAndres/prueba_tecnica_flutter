import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';
import 'package:prueba_tecnica_flutter/features/posts/data/posts_repository.dart';

/// 📌 `fetch_posts_usecase_integration_test.dart`
/// Pruebas de integración para `FetchPostsUseCase`.
///
/// ✅ **Objetivo:** Verificar que `FetchPostsUseCase` funciona correctamente con `PostsRepository` real.
/// ✅ **Alcance:** No usamos mocks; hacemos llamadas reales a la API simulada (`jsonplaceholder.typicode.com`).
void main() {
  late FetchPostsUseCase fetchPostsUseCase;
  late PostsRepository postsRepository;

  /// 🔹 **Configuración inicial:**
  /// - Se crea una instancia real de `PostsRepository`.
  /// - Se inyecta en `FetchPostsUseCase`.
  setUp(() {
    postsRepository = PostsRepository();
    fetchPostsUseCase = FetchPostsUseCase(postsRepository);
  });

  /// 📌 **Prueba: `fetchPosts` obtiene publicaciones desde la API**
  /// ✅ Llama a `fetchPosts(userId)` con un `userId` válido (1).
  /// ✅ Verifica que se reciben publicaciones correctamente.
  /// ✅ Comprueba que cada post tiene `id`, `title` y `userId`.
  test("fetchPosts debería obtener publicaciones desde la API", () async {
    final posts = await fetchPostsUseCase.execute(1);

    expect(posts.isNotEmpty, true); // Debe haber al menos un post
    expect(posts.first, contains("id")); // Cada post debe tener un `id`
    expect(posts.first, contains("title")); // Cada post debe tener un `title`
    expect(posts.first["userId"], 1); // Los posts deben pertenecer al `userId` 1
  });
}
