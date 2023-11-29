import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/app_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/aquarium_detail_tabbar.dart';
import 'package:fishfront/ui/aquarium/main_page/main_body.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AquariumDetailPage extends ConsumerStatefulWidget {
  AquariumDetailPage({Key? key}) : super(key: key);

  @override
  _AquariumDetailPageState createState() => _AquariumDetailPageState();
}

class _AquariumDetailPageState extends ConsumerState<AquariumDetailPage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
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

    return Scaffold(
      appBar: MyAppbar(
          title: "${aquariumDTO.title}",
          onTapFunction: () async {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
            await ref.read(mainProvider.notifier).notifyInit();
          }),
      bottomNavigationBar: AppBottom(),
      body: AquariumDetailTabBar(aquariumDTO),
    );
  }
}
