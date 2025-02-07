import 'package:flutter/material.dart';
import '../../domain/fetch_posts_usecase.dart';

/// 📌 `PostsProvider`  
/// Proveedor de estado que gestiona las publicaciones de los usuarios.  
/// 🔹 Usa `ChangeNotifier` para actualizar la UI cuando hay cambios.  
/// 🔹 Se comunica con `FetchPostsUseCase` para obtener publicaciones.  
/// 
/// ## Propiedades principales:  
/// - `_posts`: Lista de publicaciones obtenidas.  
/// - `_isLoading`: Indica si se están cargando los datos.  
/// - `_errorMessage`: Almacena posibles errores de la petición.  
/// 
/// ## Métodos principales:  
/// - `fetchPosts(int userId)`:  
///   - Llama a `FetchPostsUseCase` para obtener las publicaciones de un usuario.  
///   - Actualiza `_posts`, `_isLoading` y `_errorMessage`.  
///   - Usa `notifyListeners()` para actualizar la UI.  
class PostsProvider with ChangeNotifier {
  /// Caso de uso para obtener las publicaciones de un usuario.
  final FetchPostsUseCase _fetchPostsUseCase;

  /// 📌 Constructor  
  /// - **Parámetro**: `_fetchPostsUseCase` → Instancia de `FetchPostsUseCase` para manejar la lógica de negocio.  
  PostsProvider(this._fetchPostsUseCase);

  List<dynamic> _posts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  /// 📌 Getters  
  /// - `posts`: Devuelve la lista de publicaciones.  
  /// - `isLoading`: Indica si la carga está en progreso.  
  /// - `errorMessage`: Devuelve el mensaje de error (si hay alguno).  
  List<dynamic> get posts => _posts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  /// 📌 Método `fetchPosts(int userId)`  
  /// - **Parámetro**: `userId` → ID del usuario cuyas publicaciones queremos obtener.  
  /// - **Acciones**:  
  ///   - Llama al caso de uso `FetchPostsUseCase`.  
  ///   - Maneja el estado de carga (`_isLoading`).  
  ///   - Captura errores y los almacena en `_errorMessage`.  
  ///   - Notifica a la UI con `notifyListeners()`.  
  Future<void> fetchPosts(int userId) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _posts = await _fetchPostsUseCase.execute(userId);
    } catch (e) {
      _errorMessage = "Error al obtener publicaciones: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
