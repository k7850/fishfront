import 'package:fishfront/ui/aquarium/aquarium_create_page/aquarium_create_view_model.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/widgets/aquarium_create_button.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/widgets/aquarium_create_equipment.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/widgets/aquarium_create_inform.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/widgets/aquarium_create_photo.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/widgets/aquarium_create_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AquariumCreateBody extends ConsumerStatefulWidget {
  const AquariumCreateBody({super.key});

  @override
  _AquariumCreateBodyState createState() => _AquariumCreateBodyState();
}

class _AquariumCreateBodyState extends ConsumerState<AquariumCreateBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print("DetailOtherBody인잇스테이트");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("DetailOtherBody빌드됨");

    AquariumCreateModel? model = ref.watch(aquariumCreateProvider);
    if (model == null) {
      ref.read(aquariumCreateProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const AquariumCreatePhoto(),
            const SizedBox(height: 15),
            const AquariumCreateInform(),
            const SizedBox(height: 15),
            const AquariumCreateSize(),
            const SizedBox(height: 15),
            const AquariumCreateEquipment(),
            const SizedBox(height: 10),
            // for (var a in model.equipmentDTOList) Text("${a.id}: ${a.name}  , ${a.category}"),
            // for (var a in model.controllerMap.entries) Text("${a.key}: ${a.value.text}"),
            AquariumCreateButton(_formKey),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
