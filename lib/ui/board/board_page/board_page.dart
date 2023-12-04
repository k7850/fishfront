import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/my_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/board/board_page/board_body.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardPage extends ConsumerStatefulWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends ConsumerState<BoardPage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    BoardModel? model = ref.watch(boardProvider);
    if (model == null) {
      ref.read(boardProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: MyAppbar(title: "게시판", onTapFunction: () => ref.read(boardProvider.notifier).notifyInit()),
      bottomNavigationBar: const MyBottom(),
      body: WillPopScope(
        onWillPop: () {
          ParamStore ps = ref.read(paramProvider);
          onItemTapped(0, context, ps);
          // ps.addBottomNavigationBarIndex(0);
          return Future.value(false);
        },
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            print("리플래시됨");
            await ref.read(boardProvider.notifier).notifyInit();
          },
          child: const BoardBody(),
        ),
      ),
    );
  }
}
