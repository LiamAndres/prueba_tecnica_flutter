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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // ✅ Creamos instancias de los repositorios
  final postsRepository = PostsRepository();
  final userRepository = UserRepository(); 

  // ✅ Creamos casos de uso
  final fetchPostsUseCase = FetchPostsUseCase(postsRepository);
  final fetchUsersUseCase = FetchUsersUseCase(userRepository);

  runApp(MyApp(
    fetchPostsUseCase: fetchPostsUseCase,
    fetchUsersUseCase: fetchUsersUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final FetchPostsUseCase fetchPostsUseCase;
  final FetchUsersUseCase fetchUsersUseCase;

  const MyApp({super.key, required this.fetchPostsUseCase, required this.fetchUsersUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(fetchUsersUseCase)),
        ChangeNotifierProvider(create: (_) => PostsProvider(fetchPostsUseCase)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prueba Técnica Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const UserListScreen(),
      ),
    );
  }
}
