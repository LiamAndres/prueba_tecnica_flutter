
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
  bool _isLoading = false;
  String _errorMessage = '';

  List<dynamic> get users => _users;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      var box = await Hive.openBox('usersBox');
      if (box.isNotEmpty) {
        _users = box.values.toList();
      } else {
        _users = await _apiService.getUsers();
        box.addAll(_users);
      }
    } catch (e) {
      _errorMessage = "Error al obtener usuarios.";
    }

    _isLoading = false;
    notifyListeners();
  }
}
