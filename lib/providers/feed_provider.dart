import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase_client.dart';
import '../models/post.dart';

final feedProvider =
    AsyncNotifierProvider<FeedNotifier, List<Post>>(FeedNotifier.new);

class FeedNotifier extends AsyncNotifier<List<Post>> {
  int offset = 0;
  final int limit = 10;
  bool hasMore = true;
  bool isFetching = false; // ✅ important

  @override
  Future<List<Post>> build() async {
    return fetchPosts(reset: true);
  }

  Future<List<Post>> fetchPosts({bool reset = false}) async {
    if (reset) {
      offset = 0;
      hasMore = true;
    }

    if (!hasMore) return state.value ?? [];

    final response = await supabase
        .from('posts')
        .select()
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    final posts =
        (response as List).map((e) => Post.fromJson(e)).toList();

    if (posts.length < limit) hasMore = false;

    offset += limit;

    return [...(reset ? [] : state.value ?? []), ...posts];
  }

  // ✅ FIXED LOAD MORE
  Future<void> loadMore() async {
    if (isFetching || !hasMore) return;

    isFetching = true;

    try {
      final newPosts = await fetchPosts();
      state = AsyncData(newPosts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }

    isFetching = false;
  }

  // ✅ FIXED REFRESH
  Future<void> refresh() async {
    try {
      final newPosts = await fetchPosts(reset: true);
      state = AsyncData(newPosts);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}