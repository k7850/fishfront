import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/comment_dto.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/ui/_common_widgets/build_time.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardDetailComment extends ConsumerWidget {
  const BoardDetailComment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("BoardDetailComment 빌드");

    BoardDetailModel model = ref.watch(boardDetailProvider)!;
    List<CommentDTO> commentDTOList = model.boardDTO.commentDTOList;

    int userId = ref.read(sessionProvider).user?.id ?? -1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Center(child: Text("댓글 ${commentDTOList.length}", style: TextStyle(fontSize: 18, color: Colors.grey[700]))),
          const SizedBox(height: 5),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              // if (commentDTOList[index].isDelete ?? false) return const SizedBox(height: 40, child: Text("삭제된 댓글입니다."));

              return commentDTOList[index].isDelete ?? false
                  ? const SizedBox(height: 50, child: Text("삭제된 댓글입니다."))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(commentDTOList[index].username, style: const TextStyle(fontSize: 17)),
                            const SizedBox(width: 7),
                            if (commentDTOList[index].userId == userId)
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  mySnackbar(
                                    3000,
                                    mySnackbarRowAlert("댓글", " 삭제하시겠습니까", context,
                                        () => ref.read(boardDetailProvider.notifier).notifyCommentDelete(commentDTOList[index].id)),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                                  child: const Text("댓글 삭제", style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            const Spacer(),
                            Text(buildTime(commentDTOList[index].createdAt), style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Text("${commentDTOList[index].text}", style: TextStyle(color: Colors.grey[600]))),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                if (commentDTOList[index].isMyLike) {
                                  ref.read(boardDetailProvider.notifier).notifyLikeCommentDelete(commentDTOList[index].id);
                                } else {
                                  ref.read(boardDetailProvider.notifier).notifyLikeComment(commentDTOList[index].id, true);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
                                child: Row(children: [
                                  Icon(Icons.thumb_up, size: 20, color: commentDTOList[index].isMyLike ? Colors.red : Colors.black),
                                  Text(
                                    " ${commentDTOList[index].likeCommentCount}",
                                    style: TextStyle(color: commentDTOList[index].isMyLike ? Colors.red : Colors.black),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                if (commentDTOList[index].isMyDislike) {
                                  ref.read(boardDetailProvider.notifier).notifyLikeCommentDelete(commentDTOList[index].id);
                                } else {
                                  ref.read(boardDetailProvider.notifier).notifyLikeComment(commentDTOList[index].id, false);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(5)),
                                child: Row(children: [
                                  Icon(Icons.thumb_down, size: 20, color: commentDTOList[index].isMyDislike ? Colors.indigo : Colors.black),
                                  Text(
                                    " ${commentDTOList[index].dislikeCommentCount}",
                                    style: TextStyle(color: commentDTOList[index].isMyDislike ? Colors.indigo : Colors.black),
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
            },
            itemCount: commentDTOList.length,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
