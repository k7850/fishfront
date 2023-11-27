import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/app_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/aquarium_detail_tabbar.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/fish_update_page/fish_update_body.dart';
import 'package:fishfront/ui/main/main_page/main_body.dart';
import 'package:fishfront/ui/main/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdatePage extends ConsumerStatefulWidget {
  FishUpdatePage({Key? key}) : super(key: key);

  @override
  _FishUpdatePageState createState() => _FishUpdatePageState();
}

class _FishUpdatePageState extends ConsumerState<FishUpdatePage> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    MainModel? model = ref.watch(mainProvider);
    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    ParamStore paramStore = ref.read(paramProvider);

    AquariumDTO aquariumDTO = model.aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    FishDTO fishDTO = aquariumDTO.fishDTOList //
        .firstWhere((element) => element.id == paramStore.fishDetailId);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.navigate_before, color: Colors.black, size: 30),
        ),
        shape: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("${fishDTO.name}", style: TextStyle(fontSize: 25, color: Colors.black)),
        actions: [
          InkWell(
            onTap: () async {
              print("새로고침");
              await ref.read(mainProvider.notifier).notifyInit();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FishUpdatePage()));
            },
            child: Icon(Icons.menu, size: 30, color: Colors.black),
          ),
          SizedBox(width: 20),
        ],
        elevation: 0,
      ),
      bottomNavigationBar: AppBottom(),

      body: FishUpdateBody(),

      // body: RefreshIndicator(
      //   key: refreshKey,
      //   onRefresh: () async {
      //     print("리플래시됨");
      //     await ref.read(mainProvider.notifier).notifyInit();
      //   },
      //   child: AquariumDetailBody(aquariumDTO),
      // ),
    );
  }
}
