/* 
📌 ¿Qué hace esto?
✔ Muestra la lista de usuarios almacenados o traídos de la API.
✔ Tiene un botón flotante para recargar usuarios.
✔ Maneja carga y errores con CircularProgressIndicator() y mensajes de error.

 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Usuarios")),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProvider.errorMessage.isNotEmpty
              ? Center(child: Text(userProvider.errorMessage))
              : ListView.builder(
                  itemCount: userProvider.users.length,
                  itemBuilder: (context, index) {
                    final user = userProvider.users[index];
                    return ListTile(
                      title: Text(user['name']),
                      subtitle: Text(user['email']),
                      onTap: () {
                        // Navegar a detalles del usuario
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => userProvider.fetchUsers(),
        child: const Icon(Icons.download),
      ),
    );
  }
}
