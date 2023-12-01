import 'package:fishfront/data/dto/diary_dto.dart';
import 'package:fishfront/ui/_common_widgets/my_sliver_persistent_header_delegate.dart';
import 'package:fishfront/ui/aquarium/detail_diary_page/detail_diary_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_diary_page/widgets/detail_diary_bottomsheet.dart';
import 'package:fishfront/ui/aquarium/detail_diary_page/widgets/detail_diary_search.dart';
import 'package:fishfront/ui/aquarium/detail_diary_page/widgets/diary_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class DetailDiaryBody extends ConsumerStatefulWidget {
  const DetailDiaryBody({super.key});

  @override
  _DetailDiaryBodyState createState() => _DetailDiaryBodyState();
}

class _DetailDiaryBodyState extends ConsumerState<DetailDiaryBody> {
  @override
  Widget build(BuildContext context) {
    print("DetailFishBody빌드됨");

    final _formKey = GlobalKey<FormState>();

    DetailDiaryModel? model = ref.watch(detailDiaryProvider);
    if (model == null) {
      ref.read(detailDiaryProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    String newSearchTerm = model.newSearchTerm;

    List<DiaryDTO> selectDiaryList = model.diaryDTOList;

    selectDiaryList = selectDiaryList
        .where((element) =>
            element.title != null && element.title!.toLowerCase().contains(newSearchTerm.toLowerCase()) ||
            element.text != null && element.text!.toLowerCase().contains(newSearchTerm.toLowerCase()))
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
            builder: (BuildContext context) {
              return DetailDiaryBottomsheet(_formKey);
            },
          );
        },
        child: const Icon(Icons.add, size: 35),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: false,
            floating: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 70,
              maxHeight: 70,
              child: const DetailDiarySearch(),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return DiaryItem(diaryDTO: selectDiaryList[index]);
              },
              childCount: selectDiaryList.length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 15)),
        ],
      ),
    );
  }
}
