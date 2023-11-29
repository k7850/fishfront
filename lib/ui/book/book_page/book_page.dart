import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/app_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/book/book_page/book_body.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookPage extends ConsumerStatefulWidget {
  BookPage({Key? key}) : super(key: key);

  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    BookModel? model = ref.watch(bookProvider);
    if (model == null) {
      ref.read(bookProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: MyAppbar(title: "생물도감", onTapFunction: () => ref.read(bookProvider.notifier).notifyInit()),
      bottomNavigationBar: AppBottom(),
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
            await ref.read(mainProvider.notifier).notifyInit();
          },
          child: BookBody(),
        ),
      ),
    );
  }
}
