import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_view_model.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_equipment.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_inform.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_photo.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/widgets/detail_other_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_common_widgets/aquarium_textformfield.dart';

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
      return Center(child: CircularProgressIndicator());
    }

    AquariumDTO aquariumDTO = model.aquariumDTO;

    TextEditingController _title = model.title;
    TextEditingController _intro = model.intro;
    TextEditingController _size1 = model.size1;
    TextEditingController _size2 = model.size2;
    TextEditingController _size3 = model.size3;

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
            Text("${model.controllerMap.length}"),
            Text("${model.equipmentDTOList.length}"),
            Text(" "),
            for (var equipment in model.equipmentDTOList) Text("${equipment.id} : ${equipment.name},  ${equipment.category}"),
            for (var entry in model.controllerMap.entries) Text("${entry.key} : ${entry.value.text}"),
            const DetailOtherEquipment(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print("aaaaa");
                if (_formKey.currentState!.validate()) {
                  print("a3sd");
                }
              },
              child: Text("제출하기"),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
