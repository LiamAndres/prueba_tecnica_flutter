import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/user_card.dart';

/// 📌 `UserListScreen`  
/// ✅ Pantalla principal que muestra la lista de usuarios.  
///  
/// 🔹 **Características**:  
///   - Obtiene la lista de usuarios desde `UserProvider`.  
///   - Permite filtrar usuarios en tiempo real mientras se escribe.  
///   - Muestra indicadores de carga y mensajes de error.  
///   - Usa `UserCard` para mostrar cada usuario.  
///  
/// 🔹 **Dependencias**:  
///   - `UserProvider`: Se encarga de gestionar los usuarios y su estado.  
///   - `UserCard`: Widget reutilizable para mostrar los datos de cada usuario.  
///  
/// 🔹 **Ciclo de vida**:  
///   - En `initState()`, llama a `fetchUsers()` de `UserProvider`.  
///   - Usa `Future.microtask` para evitar problemas con el contexto asíncrono.  
///   - Valida `mounted` antes de acceder a `context` en `initState()`.  
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (mounted) {
        await Provider.of<UserProvider>(context, listen: false).fetchUsers();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: const Text(
          "Prueba de Ingreso",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Buscar usuario",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
                TextFormField(
                  onChanged: (query) => userProvider.filterUsers(query),
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: userProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : userProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(userProvider.errorMessage))
                    : userProvider.users.isEmpty
                        ? const Center(
                            child: Text(
                              "List is empty",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: userProvider.users.length,
                            itemBuilder: (context, index) {
                              final user = userProvider.users[index];
                              return UserCard(user: user);
                            }),
          ),
        ],
      ),
    );
  }
}
