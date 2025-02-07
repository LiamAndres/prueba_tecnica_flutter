import '../data/posts_repository.dart';
import '../../../core/usecases/usecase.dart';

/// 📌 `FetchPostsUseCase`
/// Caso de uso para obtener las publicaciones de un usuario desde el repositorio.
/// Sigue el principio de inversión de dependencias al depender de `PostsRepository` en lugar de realizar la lógica directamente.
class FetchPostsUseCase extends UseCase<List<Map<String, dynamic>>, int> {
  /// Repositorio que maneja la obtención de publicaciones desde la API.
  final PostsRepository _repository;

  /// 📌 Constructor
  /// - **Parámetro**: `_repository` → Instancia de `PostsRepository` para acceder a los datos.
  FetchPostsUseCase(this._repository);

  /// 📌 Método `execute(int params)`
  /// - **Parámetro**: `params` → ID del usuario cuyas publicaciones queremos obtener.
  /// - **Devuelve**: Una lista de mapas (`List<Map<String, dynamic>>`) con las publicaciones del usuario.
  /// - **Manejo de errores**: La lógica de manejo de errores se delega al repositorio.
  @override
  Future<List<Map<String, dynamic>>> execute(int params) async {
    return List<Map<String, dynamic>>.from(
        await _repository.fetchPosts(params));
  }
}
