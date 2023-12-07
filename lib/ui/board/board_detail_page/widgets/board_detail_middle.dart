import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_view_model.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_emoticon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardDetailMiddle extends ConsumerWidget {
  const BoardDetailMiddle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardDetailModel model = ref.watch(boardDetailProvider)!;

    BoardDTO boardDTO = model.boardDTO;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text("${boardDTO.text}", style: TextStyle(fontSize: 15, color: Colors.grey[700])),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoardDetailEmoticon(
                text: "❤️ ${boardDTO.emoticonCount.countHEART}",
                emoticonEnum: EmoticonEnum.HEART,
              ),
              BoardDetailEmoticon(
                text: "🎉 ${boardDTO.emoticonCount.countCONGRATATU}",
                emoticonEnum: EmoticonEnum.CONGRATATU,
              ),
              BoardDetailEmoticon(
                text: "👍🏼 ${boardDTO.emoticonCount.countTHUMB}",
                emoticonEnum: EmoticonEnum.THUMB,
              ),
              BoardDetailEmoticon(
                text: "😄 ${boardDTO.emoticonCount.countSMILE}",
                emoticonEnum: EmoticonEnum.SMILE,
              ),
              BoardDetailEmoticon(
                text: "😭 ${boardDTO.emoticonCount.countCRY}",
                emoticonEnum: EmoticonEnum.CRY,
              ),
              BoardDetailEmoticon(
                text: "😡 ${boardDTO.emoticonCount.countANGRY}",
                emoticonEnum: EmoticonEnum.ANGRY,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
