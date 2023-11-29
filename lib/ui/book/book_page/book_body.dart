import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/_common_widgets/my_sliver_persistent_header_delegate.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_fishclassenum.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_isfreshwater.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_item.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookBody extends ConsumerStatefulWidget {
  const BookBody({super.key});

  @override
  _BookBodyState createState() => _BookBodyState();
}

class _BookBodyState extends ConsumerState<BookBody> {
  @override
  void didChangeDependencies() {
    ref.read(bookProvider.notifier).notifySearch("");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("_BookBodyState 빌드");

    BookModel model = ref.watch(bookProvider)!;

    bool? isFreshWater = model.isFreshWater;
    FishClassEnum fishClassEnum = model.fishClassEnum;
    String? newSearchTerm = model.newSearchTerm;

    List<Book> selectBookList = model.bookList;

    if (fishClassEnum != FishClassEnum.ALL) {
      selectBookList = selectBookList.where((element) => element.fishClassEnum == fishClassEnum).toList();
    }
    if (isFreshWater != null) {
      selectBookList = selectBookList.where((element) => element.isFreshWater == isFreshWater).toList();
    }
    if (newSearchTerm != null) {
      selectBookList = selectBookList
          .where((element) =>
              element.normalName.toLowerCase().contains(newSearchTerm.toLowerCase()) ||
              (element.biologyName != null && element.biologyName!.toLowerCase().contains(newSearchTerm.toLowerCase())))
          .toList();
    }

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: false,
          floating: true,
          delegate: MySliverPersistentHeaderDelegate(
              minHeight: 127,
              maxHeight: 127,
              child: Container(
                color: Colors.white,
                child: const Column(
                  children: [
                    SizedBox(height: 10),
                    BookPageIsfreshwater(),
                    BookPageFishclassenum(),
                    BookPageSearch(),
                  ],
                ),
              )),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return BookPageItem(book: selectBookList[index]);
            },
            childCount: selectBookList.length,
          ),
        ),
      ],
    );

    // return Column(
    //   children: [
    //     const SizedBox(height: 10),
    //     const BookPageIsfreshwater(),
    //     const SizedBox(height: 5),
    //     const BookPageFishclassenum(),
    //     const BookPageSearch(),
    //     const Divider(color: Colors.grey, height: 30, thickness: 1),
    //     Expanded(
    //       child: ListView(
    //         children: [
    //           for (Book book in selectBookList) BookPageItem(book: book),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
