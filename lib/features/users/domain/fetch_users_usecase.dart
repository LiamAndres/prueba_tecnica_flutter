import '../data/user_repository.dart';
import '../../../core/usecases/usecase.dart';

class FetchUsersUseCase extends UseCase<List<Map<String, dynamic>>, void> {
  final UserRepository _repository;

  FetchUsersUseCase(this._repository);

  @override
  Future<List<Map<String, dynamic>>> execute(void _) async {
    return List<Map<String, dynamic>>.from(await _repository.fetchUsers());
  }
}
