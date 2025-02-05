/* 
📌 ¿Qué hace este archivo?
✔ FetchPostsUseCase se encarga de obtener publicaciones desde PostsRepository.
✔ PostsProvider ahora llamará a FetchPostsUseCase en lugar de PostsRepository directamente.
 */

import '../data/posts_repository.dart';
import '../../../core/usecases/usecase.dart';

class FetchPostsUseCase extends UseCase<List<Map<String, dynamic>>, int> {
  final PostsRepository _repository;

  FetchPostsUseCase(this._repository);

  @override
  Future<List<Map<String, dynamic>>> execute(int userId) async {
    return List<Map<String, dynamic>>.from(await _repository.fetchPosts(userId));
  }
}

