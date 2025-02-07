import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_flutter/features/posts/presentation/providers/posts_provider.dart';
import 'package:prueba_tecnica_flutter/features/posts/data/posts_repository.dart';
import 'package:prueba_tecnica_flutter/features/posts/domain/fetch_posts_usecase.dart';
import 'package:prueba_tecnica_flutter/features/users/data/user_repository.dart';
import 'package:prueba_tecnica_flutter/features/users/domain/fetch_users_usecase.dart';
import 'features/users/presentation/providers/user_provider.dart';
import 'features/users/presentation/pages/user_list_screen.dart';

/// 📌 `main()`
/// ✅ Punto de entrada de la aplicación Flutter.
/// ✅ Inicializa Hive para almacenamiento local.
/// ✅ Crea e inyecta las dependencias siguiendo Clean Architecture.
/// ✅ Lanza `MyApp`, que administra la configuración global.
void main() async {
  /// 🔹 Asegura que los bindings de Flutter estén inicializados antes de ejecutar código asíncrono.
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔹 Inicializa Hive para almacenamiento local.
  await Hive.initFlutter();

  // ✅ 1. Crear instancias de los repositorios (capa de datos)
  final postsRepository = PostsRepository();
  final userRepository = UserRepository();

  // ✅ 2. Crear instancias de los casos de uso (capa de dominio)
  final fetchPostsUseCase = FetchPostsUseCase(postsRepository);
  final fetchUsersUseCase = FetchUsersUseCase(userRepository);

  // ✅ 3. Ejecutar la aplicación
  runApp(MyApp(
    fetchPostsUseCase: fetchPostsUseCase,
    fetchUsersUseCase: fetchUsersUseCase,
  ));
}

/// 📌 `MyApp`
/// ✅ Configura `MultiProvider` para inyectar dependencias en toda la app.
/// ✅ Define la pantalla principal como `UserListScreen`.
class MyApp extends StatelessWidget {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUsersUseCase fetchUsersUseCase;

  const MyApp(
      {super.key,
      required this.fetchPostsUseCase,
      required this.fetchUsersUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// 🔹 Inyectamos `UserProvider` con `fetchUsersUseCase`
        ChangeNotifierProvider(create: (_) => UserProvider(fetchUsersUseCase)),

        /// 🔹 Inyectamos `PostsProvider` con `fetchPostsUseCase`
        ChangeNotifierProvider(create: (_) => PostsProvider(fetchPostsUseCase)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prueba Técnica Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserListScreen(), // ✅ Pantalla principal
      ),
    );
  }
}
