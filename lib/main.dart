import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica_flutter/features/users/presentation/providers/posts_provider.dart';
import 'features/users/presentation/providers/user_provider.dart';
import 'features/users/presentation/pages/user_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => PostsProvider()),
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
