import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/data/provider/session_provider.dart';
import 'package:fishfront/ui/_common_widgets/build_time.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_view_model.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardDetailTop extends ConsumerWidget {
  const BoardDetailTop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardDetailModel model = ref.watch(boardDetailProvider)!;
    BoardDTO boardDTO = model.boardDTO;

    int userId = ref.read(sessionProvider).user?.id ?? -1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text(boardDTO.title, style: const TextStyle(fontSize: 18)),
          Row(
            children: [
              Text(boardDTO.username, style: TextStyle(fontSize: 17, color: Colors.grey[600])),
              const SizedBox(width: 7),
              boardDTO.userId != userId
                  ? const SizedBox(height: 48)
                  : Row(
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.green),
                            minimumSize: MaterialStatePropertyAll(Size.zero),
                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 5)),
                          ),
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (_) => const BoardCreatePage()));
                          },
                          child: const Text("글 수정"),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.red),
                            minimumSize: MaterialStatePropertyAll(Size.zero),
                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 5)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            mySnackbar(
                              3000,
                              mySnackbarRowAlert("글", " 삭제하시겠습니까", context, () => ref.read(boardProvider.notifier).notifyBoardDelete(boardDTO.id)),
                            );
                          },
                          child: const Text("글 삭제"),
                        ),
                      ],
                    ),
              const Spacer(),
              Text(buildTime(boardDTO.createdAt), style: TextStyle(fontSize: 13, color: Colors.grey[600])),
              Text("ㅣ", style: TextStyle(fontSize: 13, color: Colors.grey[400])),
              Text(" 조회 ${boardDTO.viewCount}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}
