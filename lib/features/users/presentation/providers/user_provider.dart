import 'package:flutter/material.dart';
import '../../domain/fetch_users_usecase.dart';

/// 📌 `UserProvider`
/// ✅ Proveedor de estado para gestionar los usuarios en la aplicación.
///
/// 🔹 **Responsabilidades**:
///   - Gestiona el estado de la lista de usuarios (`_users`).
///   - Filtra usuarios en tiempo real (`filterUsers`).
///   - Llama a `FetchUsersUseCase` para obtener los datos.
///   - Notifica cambios a la UI con `notifyListeners()`.
///
/// 🔹 **Propiedades clave**:
///   - `_users`: Lista de usuarios completa.
///   - `_filteredUsers`: Lista filtrada basada en el input del usuario.
///   - `_isLoading`: Indica si se están cargando datos.
///   - `_errorMessage`: Guarda el mensaje de error en caso de fallos.
///
/// 🔹 **Métodos**:
///   - `fetchUsers()`: Obtiene los usuarios desde `FetchUsersUseCase`.
///   - `filterUsers(query)`: Filtra usuarios por nombre según el texto ingresado.
class UserProvider with ChangeNotifier {
  final FetchUsersUseCase _fetchUsersUseCase; // ✅ Usa FetchUsersUseCase

  UserProvider(
      this._fetchUsersUseCase); // ✅ Recibe FetchUsersUseCase por inyección de dependencias

  List<dynamic> _users = [];
  List<dynamic> _filteredUsers = [];
  bool _isLoading = false;
  String _errorMessage = '';

  /// 🔹 Obtiene la lista de usuarios filtrada
  List<dynamic> get users => _filteredUsers;

  /// 🔹 Indica si se están cargando los datos
  bool get isLoading => _isLoading;

  /// 🔹 Devuelve el mensaje de error si ocurre
  String get errorMessage => _errorMessage;

  /// 🔹 Obtiene los usuarios desde `FetchUsersUseCase`
  /// ✅ Llama a la API solo si los datos no están en almacenamiento local.
  /// ✅ Maneja estados de carga y error.
  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _users =
          await _fetchUsersUseCase.execute(null); // ✅ Llama a FetchUsersUseCase
      _filteredUsers = _users;
    } catch (e) {
      _errorMessage = "Error al obtener usuarios: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }

  /// 🔹 Filtra la lista de usuarios en base a la consulta ingresada.
  /// ✅ Busca coincidencias en los nombres de los usuarios.
  void filterUsers(String query) {
    _filteredUsers = query.isEmpty
        ? List.from(_users)
        : _users
            .where((user) =>
                user['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
    notifyListeners();
  }
}
