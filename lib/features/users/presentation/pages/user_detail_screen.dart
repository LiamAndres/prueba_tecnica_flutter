/* 
📌 ¿Qué hicimos?
✔ Mostramos la información del usuario en una Card.
✔ Mostramos las publicaciones en una lista con Card, con título y descripción.
✔ Si no hay publicaciones, muestra "No hay publicaciones".
✔ Usamos Provider para obtener los posts (lo configuraremos ahora).
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posts_provider.dart';

class UserDetailScreen extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<PostsProvider>(context, listen: false)
        .fetchPosts(widget.user['id']));
  }

  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text(widget.user['name']),
      ),
      body: Column(
        children: [
          _buildUserInfo(widget.user),
          Expanded(
            child: postsProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : postsProvider.posts.isEmpty
                    ? const Center(child: Text("No hay publicaciones"))
                    : ListView.builder(
                        itemCount: postsProvider.posts.length,
                        itemBuilder: (context, index) {
                          final post = postsProvider.posts[index];
                          return _buildPostCard(post);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(Map<String, dynamic> user) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone, color: Colors.green[800]),
                const SizedBox(width: 8),
                Text(user['phone'], style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.email, color: Colors.green[800]),
                const SizedBox(width: 8),
                Text(user['email'], style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(post['body'], style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
