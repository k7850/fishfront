import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/ui/_common_widgets/my_sliver_persistent_header_delegate.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_isaquarium.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_isphoto.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_item.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_search.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_fishclassenum.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_isfreshwater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardBody extends ConsumerStatefulWidget {
  const BoardBody({super.key});

  @override
  _BoardBodyState createState() => _BoardBodyState();
}

class _BoardBodyState extends ConsumerState<BoardBody> {
  @override
  Widget build(BuildContext context) {
    print("_BoardBodyState 빌드");

    BoardModel model = ref.watch(boardProvider)!;

    List<BoardMainDTO> boardMainDTOList = model.boardMainDTOList;

    bool? isAquarium = model.isAquarium;

    List<BoardMainDTO> selectBoardList = boardMainDTOList;
    if (isAquarium != null) {
      selectBoardList = selectBoardList.where((element) => element.isAquarium == isAquarium).toList();
    }

    // if (newSearchTerm != null) {
    //   selectBookList = selectBookList
    //       .where((element) =>
    //           element.normalName.toLowerCase().contains(newSearchTerm.toLowerCase()) ||
    //           (element.biologyName != null && element.biologyName!.toLowerCase().contains(newSearchTerm.toLowerCase())))
    //       .toList();
    // }

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: MySliverPersistentHeaderDelegate(
            minHeight: 108,
            maxHeight: 108,
            child: Stack(
              children: [
                Container(
                  // color: Colors.blue.shade200,
                  color: Colors.white,
                  child: const Column(
                    children: [
                      SizedBox(height: 13),
                      BoardPageIsAquarium(),
                      SizedBox(height: 2),
                      BoardPageSearch(),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size.zero),
                      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
                    ),
                    onPressed: () {},
                    child: Text("글 작성"),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList.separated(
          itemBuilder: (BuildContext context, int index) {
            return BoardPageItem(boardMainDTO: selectBoardList[index]);
          },
          itemCount: selectBoardList.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.grey, height: 1, thickness: 1),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 515)),
      ],
    );
  }
}
