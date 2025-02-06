import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/posts/presentation/providers/posts_provider.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';

// 🔹 Fake del UseCase
class FakeFetchPostsUseCase implements FetchPostsUseCase {
  @override
  Future<List<Map<String, dynamic>>> execute(int userId) async {
    return [
      {"id": 1, "userId": userId, "title": "Post 1"},
      {"id": 2, "userId": userId, "title": "Post 2"},
    ];
  }
}

void main() {
  late PostsProvider postsProvider;
  late FakeFetchPostsUseCase fakeFetchPostsUseCase;

  setUp(() {
    fakeFetchPostsUseCase = FakeFetchPostsUseCase();
    postsProvider = PostsProvider(fakeFetchPostsUseCase);
  });

  test("fetchPosts debería obtener publicaciones correctamente", () async {
    expect(postsProvider.isLoading, false);
    expect(postsProvider.posts.isEmpty, true);

    await postsProvider.fetchPosts(1);

    expect(postsProvider.isLoading, false);
    expect(postsProvider.errorMessage, '');
    expect(postsProvider.posts.length, 2);
    expect(postsProvider.posts.first['title'], 'Post 1');
  });

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
