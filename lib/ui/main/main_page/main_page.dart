import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/app_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/main/main_page/main_body.dart';
import 'package:fishfront/ui/main/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    MainModel? model = ref.watch(mainProvider);
    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }
    List<AquariumDTO> aquariumDTOList = model.aquariumDTOList;

    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("어항 관리", style: TextStyle(fontSize: 25, color: Colors.black)),
        actions: [
          InkWell(
            onTap: () async {
              await ref.read(mainProvider.notifier).notifyInit();
            },
            child: Icon(Icons.menu, size: 30, color: Colors.black),
          ),
          SizedBox(width: 20),
        ],
        elevation: 0,
      ),
      bottomNavigationBar: AppBottom(),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            print("리플래시됨");
            await ref.read(mainProvider.notifier).notifyInit();
          },
          child: MainBody(aquariumDTOList),
        ),
      ),
    );
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    final mContext = navigatorKey.currentContext;
    DateTime now = DateTime.now();

    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      mySnackbar(
        mContext,
        2000,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("'뒤로' 버튼을 한 번 더 누르시면 종료됩니다.")],
        ),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }
}
