import 'package:flutter/material.dart';
import '../../domain/fetch_users_usecase.dart';

class UserProvider with ChangeNotifier {
  final FetchUsersUseCase _fetchUsersUseCase;

  UserProvider(this._fetchUsersUseCase);

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
      _users = await _fetchUsersUseCase.execute(null); // ✅ Se pasa null como argumento
      _filteredUsers = _users;
    } catch (e) {
      _errorMessage = "Error al obtener usuarios: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }

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
