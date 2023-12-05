import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/board/board_detail_page/widgets/board_detail_emoticon.dart';
import 'package:flutter/material.dart';

class BoardDetailMiddle extends StatelessWidget {
  const BoardDetailMiddle({
    super.key,
    required this.boardDTO,
  });

  final BoardDTO boardDTO;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Text("${boardDTO.text}", style: TextStyle(fontSize: 15, color: Colors.grey[700])),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BoardDetailEmoticon(
                text: "❤️ ${boardDTO.emoticonCount.countHEART}",
                isMyEmoticon: boardDTO.emoticonCount.myEmoticonEnum == EmoticonEnum.HEART,
              ),
              BoardDetailEmoticon(
                text: "🎉 ${boardDTO.emoticonCount.countCONGRATATU}",
                isMyEmoticon: boardDTO.emoticonCount.myEmoticonEnum == EmoticonEnum.CONGRATATU,
              ),
              BoardDetailEmoticon(
                text: "👍🏼 ${boardDTO.emoticonCount.countTHUMB}",
                isMyEmoticon: boardDTO.emoticonCount.myEmoticonEnum == EmoticonEnum.THUMB,
              ),
              BoardDetailEmoticon(
                text: "😄 ${boardDTO.emoticonCount.countSMILE}",
                isMyEmoticon: boardDTO.emoticonCount.myEmoticonEnum == EmoticonEnum.SMILE,
              ),
              BoardDetailEmoticon(
                text: "😭 ${boardDTO.emoticonCount.countCRY}",
                isMyEmoticon: boardDTO.emoticonCount.myEmoticonEnum == EmoticonEnum.CRY,
              ),
              BoardDetailEmoticon(
                text: "😡 ${boardDTO.emoticonCount.countANGRY}",
                isMyEmoticon: boardDTO.emoticonCount.myEmoticonEnum == EmoticonEnum.ANGRY,
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
