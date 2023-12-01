import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_view_model.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_button.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_equipment.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_inform.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_photo.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailOtherBody extends ConsumerStatefulWidget {
  const DetailOtherBody({super.key});

  @override
  _DetailOtherBodyState createState() => _DetailOtherBodyState();
}

class _DetailOtherBodyState extends ConsumerState<DetailOtherBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print("DetailOtherBody인잇스테이트");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("DetailOtherBody빌드됨");

    DetailOtherModel? model = ref.watch(detailOtherProvider);
    if (model == null) {
      ref.read(detailOtherProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const DetailOtherPhoto(),
            const SizedBox(height: 15),
            const DetailOtherInform(),
            const SizedBox(height: 15),
            const DetailOtherSize(),
            const SizedBox(height: 15),
            const DetailOtherEquipment(),
            const SizedBox(height: 10),
            // for (var a in model.equipmentDTOList) Text("${a.id}: ${a.name}  , ${a.category}"),
            // for (var a in model.controllerMap.entries) Text("${a.key}: ${a.value.text}"),
            DetailOtherButton(_formKey),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
