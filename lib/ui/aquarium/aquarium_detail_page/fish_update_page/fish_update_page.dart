import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/app_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/fish_update_page/fish_update_body.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdatePage extends ConsumerStatefulWidget {
  const FishUpdatePage({Key? key}) : super(key: key);

  @override
  _FishUpdatePageState createState() => _FishUpdatePageState();
}

class _FishUpdatePageState extends ConsumerState<FishUpdatePage> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    FishUpdateModel? model = ref.watch(fishUpdateProvider);
    if (model == null) {
      ref.read(fishUpdateProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    ParamStore paramStore = ref.read(paramProvider);

    FishDTO fishDTO = ref
        .watch(mainProvider)!
        .aquariumDTOList
        .expand((element) => element.fishDTOList) //
        .firstWhere((element) => element.id == paramStore.fishDetailId);

    return Scaffold(
      appBar: MyAppbar(
          title: "${fishDTO.name}",
          onTapFunction: () async {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => FishUpdatePage()));
            await ref.read(mainProvider.notifier).notifyInit();
          }),
      bottomNavigationBar: const AppBottom(),
      body: FishUpdateBody(),
    );
  }
}
