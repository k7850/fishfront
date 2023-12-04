import 'package:fishfront/data/dto/board_dto.dart';
import 'package:fishfront/ui/_common_widgets/my_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_body.dart';
import 'package:fishfront/ui/board/board_detail_page/board_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardDetailPage extends ConsumerWidget {
  const BoardDetailPage({super.key});

  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardDetailModel? model = ref.watch(boardDetailProvider);
    if (model == null) {
      ref.read(boardDetailProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }
    BoardDTO boardDTO = model.boardDTO;

    return Scaffold(
      appBar: MyAppbar(title: boardDTO.title, onTapFunction: () => ref.read(boardDetailProvider.notifier).notifyInit()),
      bottomNavigationBar: const MyBottom(),
      body: const BoardDetailBody(),
    );
  }
}
