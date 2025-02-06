import 'package:flutter_test/flutter_test.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';
import 'package:prueba_tecnica_flutter/features/posts/data/posts_repository.dart';

void main() {
  late FetchPostsUseCase fetchPostsUseCase;
  late PostsRepository postsRepository;

  setUp(() {
    postsRepository = PostsRepository();
    fetchPostsUseCase = FetchPostsUseCase(postsRepository);
  });

  test("fetchPosts debería obtener publicaciones desde la API", () async {
    final posts = await fetchPostsUseCase.execute(1);

    expect(posts.isNotEmpty, true);
    expect(posts.first, contains("id"));
    expect(posts.first, contains("title"));
    expect(posts.first["userId"], 1);
  });
}
