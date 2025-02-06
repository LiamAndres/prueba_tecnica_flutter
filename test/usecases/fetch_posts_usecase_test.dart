import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';
import 'package:prueba_tecnica_flutter/features/posts/data/posts_repository.dart';
import 'fetch_posts_usecase_test.mocks.dart';

// 🔹 Generamos un Mock de PostsRepository
@GenerateMocks([PostsRepository])
void main() {
  late FetchPostsUseCase fetchPostsUseCase;
  late MockPostsRepository mockPostsRepository;

  setUp(() {
    mockPostsRepository = MockPostsRepository();
    fetchPostsUseCase = FetchPostsUseCase(mockPostsRepository);
  });

  test("Debería obtener la lista de posts correctamente", () async {
    // 🔹 Datos simulados que devolverá el mock
    final fakePosts = [
      {"id": 1, "userId": 1, "title": "Post 1"},
      {"id": 2, "userId": 1, "title": "Post 2"},
    ];

    // 🔹 Simulamos que fetchPosts devuelve estos datos cuando recibe un userId
    when(mockPostsRepository.fetchPosts(1)).thenAnswer((_) async => fakePosts);

    // 🔹 Ejecutamos el caso de uso con userId = 1
    final result = await fetchPostsUseCase.execute(1);

    // 🔹 Verificamos que se llamara correctamente al repositorio
    verify(mockPostsRepository.fetchPosts(1)).called(1);

    // 🔹 Verificamos que los datos sean los esperados
    expect(result, equals(fakePosts));
  });

  test("Debería lanzar una excepción cuando el repositorio falla", () async {
    when(mockPostsRepository.fetchPosts(1)).thenThrow(Exception("Error en la API"));

    expect(fetchPostsUseCase.execute(1), throwsException);
  });
}
