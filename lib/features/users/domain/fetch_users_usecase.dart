import '../data/user_repository.dart';

class FetchUsersUseCase {
  final UserRepository _repository;

  FetchUsersUseCase(this._repository);

  Future<List<dynamic>> execute() async {
    return await _repository.fetchUsers();
  }
}
