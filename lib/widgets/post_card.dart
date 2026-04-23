import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/post.dart';
import '../providers/like_provider.dart';
import '../views/detail_screen.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final p = ref.watch(likeProvider)[post.id] ?? post;
    final width = MediaQuery.of(context).size.width;

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailScreen(post: p),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 25,
                spreadRadius: 5,
              )
            ],
          ),
          child: Column(
            children: [
              Hero(
                tag: p.id,
                child: Image.network(
                  p.mediaThumbUrl,
                  width: width,
                  height: width,
                  fit: BoxFit.cover,
                  cacheWidth: width.toInt(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        p.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                            p.isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        ref
                            .read(likeProvider.notifier)
                            .toggle(p, context);
                      },
                    ),
                    Text('${p.likeCount}')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}