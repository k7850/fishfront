import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/equipment_dto.dart';
import 'package:fishfront/ui/_common_widgets/aquarium_textformfield.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailOtherEquipment extends ConsumerWidget {
  const DetailOtherEquipment({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailOtherModel model = ref.watch(detailOtherProvider)!;

    AquariumDTO aquariumDTO = model.aquariumDTO;
    List<EquipmentDTO> equipmentDTOList = model.equipmentDTOList;

    Map<int, TextEditingController> controllerMap = model.controllerMap;

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("어항 장비", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          ElevatedButton(
            onPressed: () {
              print("장비추가버튼누름");
              showDialog(
                context: context,
                builder: (context) {
                  TextEditingController createEquipment = new TextEditingController();
                  return AlertDialog(
                      title: Text("장비 추가하기"),
                      content: TextFormField(
                        controller: createEquipment,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          hintText: "장비 분류를 입력하세요.",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.edit_note, size: 30),
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            print("asd");
                            ref.read(detailOtherProvider.notifier).notifyEquipmentCreate(createEquipment.text);
                            Navigator.pop(context);
                          },
                          child: Text("완료"),
                        )
                      ]);
                },
              );
            },
            child: const Text("장비 추가하기"),
          ),
          for (var entry in controllerMap.entries)
            for (var equipment in equipmentDTOList)
              equipment.id != entry.key
                  ? const SizedBox()
                  : Row(
                      children: [
                        Expanded(
                          child: AquariumTextFormField(equipment.category, entry.value, validateOkEmpty(),
                              (String value) => ref.read(detailOtherProvider.notifier).notifyEquipmentUpdate(equipment.id, value)),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            print("장비제거누름 ${equipment.id}, ${entry.key}, ${entry.value.text}");
                            ref.read(detailOtherProvider.notifier).notifyEquipmentDelete(equipment.id);
                          },
                          style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 5))),
                          child: Text("장비 제거", style: TextStyle(color: Colors.grey[600])),
                        ),
                      ],
                    ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
