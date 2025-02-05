/* 
📌 FetchUsersUseCase
✔ Se encarga de obtener la lista de usuarios desde UserRepository.
✔ Usa el patrón UseCase para desacoplar la lógica de aplicación.
✔ Es utilizado por UserProvider para recuperar los datos.
*/

import '../data/user_repository.dart';
import '../../../core/usecases/usecase.dart';

class FetchUsersUseCase extends UseCase<List<Map<String, dynamic>>, void> {
  final UserRepository _repository;

  FetchUsersUseCase(this._repository);

  @override
  Future<List<Map<String, dynamic>>> execute(void params) async {
    return List<Map<String, dynamic>>.from(await _repository.fetchUsers());
  }
}
