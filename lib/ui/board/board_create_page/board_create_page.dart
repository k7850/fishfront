import 'package:fishfront/ui/_common_widgets/my_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_body.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardCreatePage extends ConsumerStatefulWidget {
  const BoardCreatePage({Key? key}) : super(key: key);

  @override
  _BoardCreatePageState createState() => _BoardCreatePageState();
}

class _BoardCreatePageState extends ConsumerState<BoardCreatePage> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    BoardCreateModel? model = ref.watch(boardCreateProvider);
    if (model == null) {
      ref.read(boardCreateProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: MyAppbar(title: "글 작성", onTapFunction: () {}),
      bottomNavigationBar: const MyBottom(),
      body: const BoardCreateBody(),
    );
  }
}
