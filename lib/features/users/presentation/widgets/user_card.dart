import 'package:flutter/material.dart';
import '../pages/user_detail_screen.dart';

/// 📌 `UserCard`
/// ✅ Widget reutilizable para mostrar la información de un usuario en una tarjeta.
///
/// 🔹 **Responsabilidades**:
///   - Muestra el nombre, teléfono y correo del usuario.
///   - Proporciona un botón para navegar a `UserDetailScreen`.
///
/// 🔹 **Propiedades**:
///   - `user`: Recibe un `Map<String, dynamic>` con los datos del usuario.
///
/// 🔹 **Diseño**:
///   - Se presenta en una `Card` con `elevation` para dar efecto visual.
///   - Usa `Row` para mostrar iconos junto con la información de contacto.
///   - Contiene un botón `TextButton` que permite navegar a la pantalla de detalles del usuario.
class UserCard extends StatelessWidget {
  final Map<String, dynamic> user; // ✅ Datos del usuario

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4, // ✅ Agrega sombra a la tarjeta para destacar
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Nombre del usuario
            Text(
              user['name'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),

            // 🔹 Teléfono del usuario
            Row(
              children: [
                Icon(Icons.phone, color: Colors.green[800]),
                const SizedBox(width: 8),
                Text(
                  user['phone'],
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // 🔹 Correo electrónico del usuario
            Row(
              children: [
                Icon(Icons.email, color: Colors.green[800]),
                const SizedBox(width: 8),
                Text(
                  user['email'],
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 🔹 Botón para ver publicaciones del usuario
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailScreen(user: user),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green[800],
                ),
                child: const Text("VER PUBLICACIONES"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
