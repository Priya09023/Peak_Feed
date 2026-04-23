class Post {
  final String id;
  final DateTime createdAt;
  final String mediaThumbUrl;
  final String mediaMobileUrl;
  final String mediaRawUrl;
  final int likeCount;
  final bool isLiked; // local state

  Post({
    required this.id,
    required this.createdAt,
    required this.mediaThumbUrl,
    required this.mediaMobileUrl,
    required this.mediaRawUrl,
    required this.likeCount,
    this.isLiked = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      mediaThumbUrl: json['media_thumb_url'],
      mediaMobileUrl: json['media_mobile_url'],
      mediaRawUrl: json['media_raw_url'],
      likeCount: json['like_count'],
    );
  }

  Post copyWith({
    int? likeCount,
    bool? isLiked,
  }) {
    return Post(
      id: id,
      createdAt: createdAt,
      mediaThumbUrl: mediaThumbUrl,
      mediaMobileUrl: mediaMobileUrl,
      mediaRawUrl: mediaRawUrl,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}