import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/board_main_dto.dart';
import 'package:fishfront/ui/_common_widgets/my_sliver_persistent_header_delegate.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_page.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_isphoto.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_item.dart';
import 'package:fishfront/ui/board/board_page/widgets/board_page_search.dart';
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

    bool isLastPage = model.isLastPage;

    List<BoardMainDTO> boardMainDTOList = model.boardMainDTOList;

    bool? isPhoto = model.isPhoto;

    List<BoardMainDTO> selectBoardList = boardMainDTOList;
    if (isPhoto == true) {
      selectBoardList = selectBoardList.where((element) => element.photoList.isNotEmpty).toList();
    }
    if (isPhoto == false) {
      selectBoardList = selectBoardList.where((element) => element.video != null && element.video!.isNotEmpty).toList();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BoardCreatePage())),
        child: const Icon(Icons.add, size: 35),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 105,
              maxHeight: 105,
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const BoardPageIsPhoto(),
                    BoardPageSearch(),
                  ],
                ),
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
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () => ref.read(boardProvider.notifier).notifyInitAdd(),
              child: Container(
                height: 45,
                decoration: BoxDecoration(color: Colors.yellow[700], border: const Border(top: BorderSide(color: Colors.grey))),
                child: Center(child: Text(isLastPage ? "마지막 글입니다." : "더 보기", style: const TextStyle(fontSize: 17))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
