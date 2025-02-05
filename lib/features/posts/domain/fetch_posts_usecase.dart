/* 
📌 ¿Qué hace este archivo?
✔ FetchPostsUseCase se encarga de obtener publicaciones desde PostsRepository.
✔ PostsProvider ahora llamará a FetchPostsUseCase en lugar de PostsRepository directamente.
 */

import '../data/posts_repository.dart'; // ✅ Importamos el repositorio

class FetchPostsUseCase {
  final PostsRepository _repository;

  FetchPostsUseCase(this._repository); // ✅ Constructor que recibe el repositorio

  Future<List<dynamic>> execute(int userId) async {
    return await _repository.fetchPosts(userId); // ✅ Llama al repositorio
  }
}
