import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/feed_provider.dart';
import '../widgets/post_card.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(feedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Feed")),
      body: feed.when(
        data: (posts) => RefreshIndicator(
          onRefresh: () async {
            await ref.read(feedProvider.notifier).refresh();
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(), // ✅ IMPORTANT
            itemCount: posts.length,
            itemBuilder: (context, index) {
              
              // 🔥 FIX: trigger before end
              if (index >= posts.length - 2) {
                ref.read(feedProvider.notifier).loadMore();
              }

              return PostCard(post: posts[index]);
            },
          ),
        ),
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}