import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardDetailEmoticon extends ConsumerWidget {
  const BoardDetailEmoticon({
    super.key,
    required this.text,
    required this.emoticonEnum,
  });

  final String text;
  final EmoticonEnum emoticonEnum;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardDetailModel model = ref.watch(boardDetailProvider)!;

    BoardDTO boardDTO = model.boardDTO;

    bool isMyEmoticon = boardDTO.emoticonCount.myEmoticonEnum == emoticonEnum;

    return InkWell(
      onTap: () {
        if (isMyEmoticon) {
          ref.read(boardDetailProvider.notifier).notifyEmoticonDelete(emoticonEnum, boardDTO.id);
        } else {
          ref.read(boardDetailProvider.notifier).notifyEmoticon(emoticonEnum, boardDTO.id);
        }
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.14),
        padding: const EdgeInsets.symmetric(vertical: 2),
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: boardDTO.emoticonCount.myEmoticonEnum == emoticonEnum ? Colors.blue : Colors.grey[400], borderRadius: BorderRadius.circular(5)),
        child: Text(" $text ", style: const TextStyle(fontSize: 17)),
      ),
    );
  }
}
