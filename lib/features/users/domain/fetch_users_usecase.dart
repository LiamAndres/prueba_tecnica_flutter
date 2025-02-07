import '../data/user_repository.dart';
import '../../../core/usecases/usecase.dart';

/// 📌 `FetchUsersUseCase`  
/// Responsable de recuperar la lista de usuarios desde `UserRepository`.  
///  
/// 🔹 **Propósito**:  
///   - Aplica el patrón **Use Case** para desacoplar la lógica de negocio.  
///   - Permite que `UserProvider` solicite la lista de usuarios de manera estructurada.  
///  
/// 🔹 **Dependencias**:  
///   - `UserRepository`: Se usa para obtener los usuarios desde la API o almacenamiento local.  
///  
/// 🔹 **Método principal**:  
///   - `execute(void params) -> Future<List<Map<String, dynamic>>>`  
///     - Llama a `fetchUsers()` en `UserRepository`.  
///     - Convierte la respuesta en una lista de mapas (`List<Map<String, dynamic>>`).  
///     - Retorna la lista de usuarios.  
///  
/// 🔹 **Beneficios**:  
///   - Facilita pruebas unitarias al desacoplar la lógica de obtención de datos.  
///   - Sigue el principio de responsabilidad única (**SRP** en SOLID).  
///   - Permite cambiar la fuente de datos sin afectar otras capas.  

class FetchUsersUseCase extends UseCase<List<Map<String, dynamic>>, void> {
  /// 📌 Referencia al repositorio de usuarios.
  final UserRepository _repository;

  /// 📌 Constructor: Recibe el repositorio como dependencia.
  FetchUsersUseCase(this._repository);

  /// 📌 Ejecuta la obtención de usuarios.
  ///  
  /// 🔹 **Flujo de trabajo**:  
  ///   1️⃣ Llama a `fetchUsers()` en `UserRepository`.  
  ///   2️⃣ Convierte la respuesta a `List<Map<String, dynamic>>`.  
  ///   3️⃣ Retorna la lista de usuarios.  
  @override
  Future<List<Map<String, dynamic>>> execute(void params) async {
    return List<Map<String, dynamic>>.from(await _repository.fetchUsers());
  }
}
