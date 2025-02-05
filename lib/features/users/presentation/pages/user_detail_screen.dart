/* 
📌 ¿Qué hicimos?
✔ Mostramos la información del usuario en una Card.
✔ Mostramos las publicaciones en una lista con Card, con título y descripción.
✔ Si no hay publicaciones, muestra "No hay publicaciones".

 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../posts/presentation/providers/posts_provider.dart';
import '../../../posts/presentation/widgets/post_card.dart';

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
                          return PostCard(
                              post: post);
                        }),
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
}
