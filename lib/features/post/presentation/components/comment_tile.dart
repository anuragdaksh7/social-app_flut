import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/features/auth/domain/entities/app_user.dart';
import 'package:social/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social/features/post/domain/entities/comment.dart';
import 'package:social/features/post/presentation/cubits/post_cubit.dart';

class CommentTile extends StatefulWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  AppUser? currentUser;
  bool isOwnPost = false;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
    isOwnPost = currentUser!.uid == widget.comment.userId;
  }

  void showOptions() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete Comment?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Cancel")),
                TextButton(
                  onPressed: () {
                    context.read<PostCubit>().removeComment(
                        widget.comment.postId, widget.comment.id);
                  },
                  child: const Text("Delete"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Text(
            widget.comment.userName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(widget.comment.text),
          const Spacer(),
          if (isOwnPost)
            GestureDetector(
              onTap: showOptions,
              child: Icon(
                Icons.more_horiz,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
        ],
      ),
    );
  }
}
