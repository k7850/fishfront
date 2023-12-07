import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/build_time.dart';
import 'package:fishfront/ui/_common_widgets/get_matchword_spans.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_page.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../_core/constants/http.dart';
import '../../../../_core/constants/size.dart';

class BoardPageItem extends ConsumerWidget {
  const BoardPageItem({
    super.key,
    required this.boardMainDTO,
  });

  final BoardMainDTO boardMainDTO;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String keyword = ref.read(boardProvider)!.controller.text;

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      color: boardMainDTO.isView ? const Color.fromRGBO(210, 210, 210, 1) : Colors.white,
      child: InkWell(
        onTap: () {
          ParamStore paramStore = ref.read(paramProvider);
          paramStore.addBoardDetailId(boardMainDTO.id);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const BoardDetailPage()));
        },
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text("${boardMainDTO.username}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
                  // child: Text(
                  //   "${boardMainDTO.title}",
                  //   style: const TextStyle(fontSize: 15, color: Colors.black),
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  // ),
                  child: keyword.isEmpty
                      ? Text(
                          boardMainDTO.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 15, color: Colors.black, fontFamily: "Giants"),
                        )
                      : RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: const TextStyle(fontSize: 15, color: Colors.black, fontFamily: "Giants"),
                            children: getMatchWordSpans(boardMainDTO.title, keyword, const TextStyle(color: Colors.red)),
                          ),
                        ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"),
                      text: buildTime(boardMainDTO.createdAt),
                      children: [
                        TextSpan(
                          text: "ㅣ",
                          style: TextStyle(fontSize: 13, color: Colors.grey[400], fontFamily: "Giants"),
                        ),
                        TextSpan(
                          text: " 조회 ${boardMainDTO.viewCount}",
                          style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            Stack(
              alignment: const Alignment(0.8, 0.8),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: boardMainDTO.photoList.isNotEmpty
                      ? Image.network(
                          "$imageURL${boardMainDTO.photoList[0]}",
                          width: sizeGetScreenWidth(context) * 0.16,
                          height: sizeGetScreenWidth(context) * 0.16,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              width: sizeGetScreenWidth(context) * 0.16,
                              height: sizeGetScreenWidth(context) * 0.16,
                            );
                          },
                        )
                      : boardMainDTO.video != null && boardMainDTO.video!.isNotEmpty
                          ? Image.network(
                              "$imageURL/videos/${boardMainDTO.video}.png",
                              width: sizeGetScreenWidth(context) * 0.16,
                              height: sizeGetScreenWidth(context) * 0.16,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return SizedBox(
                                  width: sizeGetScreenWidth(context) * 0.16,
                                  height: sizeGetScreenWidth(context) * 0.16,
                                );
                              },
                            )
                          : const SizedBox(),
                ),
                boardMainDTO.photoList.length > 1
                    ? Container(
                        decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),
                        padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                        child: Text(
                          "+${boardMainDTO.photoList.length - 1}",
                          style: const TextStyle(fontSize: 12, color: Colors.white, fontFamily: "JamsilRegular"),
                        ),
                      )
                    : boardMainDTO.video != null && boardMainDTO.video!.isNotEmpty
                        ? Container(
                            decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),
                            padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                            child: Icon(Icons.skip_next_outlined, size: 15, color: Colors.white),
                          )
                        : const SizedBox(),
              ],
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(5)),
              width: sizeGetScreenWidth(context) * 0.09,
              height: sizeGetScreenWidth(context) * 0.16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${boardMainDTO.commentCount}"),
                  const SizedBox(height: 2),
                  const Text("댓글", style: TextStyle(fontSize: 12, color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
