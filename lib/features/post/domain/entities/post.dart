import 'package:social/features/post/domain/entities/comment.dart';

class Post {
  final String id;
  final String userId;
  final String userName;
  final String text;
  final String imageUrl;
  final DateTime timestamp;
  final List<String> likes;
  final List<Comment> comments;

  Post({
    required this.id,
    required this.userId,
    required this.userName,
    required this.text,
    required this.imageUrl,
    required this.timestamp,
    required this.likes,
    required this.comments,
  });

  Post copyWith({String? imageUrl}) {
    return Post(
      id: id,
      userId: userId,
      userName: userName,
      text: text,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp,
      likes: likes,
      comments: comments,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': userName,
      'text': text,
      'imageUrl': imageUrl,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    final List<Comment> comments = (json['comments'] != null)
        ? ((json['comments'] as List<dynamic>?)
                ?.map((commentJson) => Comment.fromJson(commentJson))
                .toList() ??
            [])
        : [];
    return Post(
        id: json['id'],
        userId: json['userId'],
        userName: json['name'],
        text: json['text'],
        imageUrl: json['imageUrl'],
        timestamp:
            DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
        likes: List<String>.from(json['likes'] ?? []),
        comments: comments);
  }
}
