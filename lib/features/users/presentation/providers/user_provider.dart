/* 
📌 ¿Qué hace esto?
✔ Verifica si los usuarios ya están almacenados en Hive antes de hacer la petición a la API.
✔ Si no hay datos locales, llama a la API y los guarda en Hive.
✔ Maneja estados de carga y error para la UI.

 */
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../core/network/api_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<dynamic> _users = [];
  List<dynamic> _filteredUsers = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<dynamic> get users => _filteredUsers;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      var box = await Hive.openBox('usersBox');

      if (box.isNotEmpty) {
        // Convertimos cada valor en un Map<String, dynamic> para evitar errores de tipo
        _users = box.values.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        _users = await _apiService.getUsers();
        for (var user in _users) {
          box.add(user);
        }
      }

      _filteredUsers = _users;
    } catch (e) {
      _errorMessage = "Error al obtener usuarios.";
    }

    _isLoading = false;
    notifyListeners();
  }

  // Método para filtrar usuarios por nombre
  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers =
          List.from(_users); // Se mantiene la referencia correcta
    } else {
      _filteredUsers = _users
          .where((user) =>
              user['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    notifyListeners(); // Actualiza la UI correctamente
  }
}
