import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/supabase_client.dart';
import '../models/post.dart';

final likeProvider =
    NotifierProvider<LikeNotifier, Map<String, Post>>(LikeNotifier.new);

class LikeNotifier extends Notifier<Map<String, Post>> {
  final userId = "user_123";

  @override
  Map<String, Post> build() => {};

  void toggle(Post post, BuildContext context) async {
    final current = state[post.id] ?? post;

    final updated = current.copyWith(
      isLiked: !current.isLiked,
      likeCount:
          current.isLiked ? current.likeCount - 1 : current.likeCount + 1,
    );

    // ✅ Optimistic UI
    state = {...state, post.id: updated};

    try {
      await supabase.rpc('toggle_like', params: {
        'p_post_id': post.id,
        'p_user_id': userId,
      });
    } catch (e) {
      // ❌ revert on failure
      state = {...state, post.id: current};

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No internet. Reverted.")),
      );
    }
  }
}