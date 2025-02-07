import 'package:flutter/material.dart';

/// 📌 `PostCard`
/// Widget reutilizable para mostrar la información de una publicación.
///
/// 🔹 **Propósito**:
///   - Representa visualmente una publicación dentro de la app.
///   - Usa una `Card` con `elevation` para resaltar el contenido.
///
/// 🔹 **Propiedades**:
///   - `post`: Recibe un `Map<String, dynamic>` con la información de la publicación.
///     - `title`: Título de la publicación.
///     - `body`: Contenido de la publicación.
///
/// 🔹 **Diseño**:
///   - Usa `Padding` para un margen interno adecuado.
///   - Muestra el título en negrita y con mayor tamaño.
///   - Muestra el contenido en un tamaño estándar para facilitar la lectura.
class PostCard extends StatelessWidget {
  /// 📌 `post` → Mapa con los datos de la publicación.
  final Map<String, dynamic> post;

  /// 📌 Constructor
  /// - **Parámetro requerido**: `post` → Datos de la publicación.
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📌 Título de la publicación
            Text(
              post['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),

            /// 📌 Contenido de la publicación
            Text(
              post['body'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
