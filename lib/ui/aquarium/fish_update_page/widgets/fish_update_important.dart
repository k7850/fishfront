import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_alertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../_core/constants/enum.dart';
import '../../../../../_core/utils/validator_util.dart';
import '../../../../../data/dto/aquarium_dto.dart';
import '../../../../../data/dto/fish_dto.dart';
import '../../../_common_widgets/aquarium_textformfield.dart';
import '../../../_common_widgets/my_checkbox.dart';
import '../fish_update_view_model.dart';

class FishUpdateImportant extends ConsumerStatefulWidget {
  const FishUpdateImportant({
    super.key,
  });

  @override
  _FishUpdateImportantState createState() => _FishUpdateImportantState();
}

class _FishUpdateImportantState extends ConsumerState<FishUpdateImportant> {
  @override
  Widget build(BuildContext context) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    FishDTO fishDTO = model.fishDTO;
    AquariumDTO aquariumDTO = model.aquariumDTO;

    TextEditingController _name = model.name;

    FishClassEnum fishClassEnum = model.fishClassEnum;

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("필수 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          AquariumTextFormField("생물 이름", _name, validateNormal(), (String value) => ref.read(fishUpdateProvider.notifier).notifyName(value)),
          Container(
            alignment: const Alignment(-1, 0),
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("소속 어항", style: TextStyle(color: Colors.grey[600])),
          ),
          InkWell(
            onTap: () {
              print("소속어항");
              ScaffoldMessenger.of(context).clearSnackBars();
              // List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;

              showDialog(
                context: context,
                builder: (context) {
                  return FishUpdateAlertdialog();
                },
              );
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text("${aquariumDTO.title}", style: TextStyle(fontSize: 17)),
                ),
                const Divider(color: Colors.black38, height: 1, thickness: 1),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 5),
            alignment: const Alignment(-1, 0),
            child: Text("생물 종류", style: TextStyle(color: Colors.grey[600])),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (fishClassEnum != FishClassEnum.FISH) {
                    ref.read(fishUpdateProvider.notifier).notifyFishClassEnum(FishClassEnum.FISH);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "물고기", isChecked: fishClassEnum == FishClassEnum.FISH),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (fishClassEnum != FishClassEnum.OTHER) {
                    ref.read(fishUpdateProvider.notifier).notifyFishClassEnum(FishClassEnum.OTHER);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "기타 생물", isChecked: fishClassEnum == FishClassEnum.OTHER),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (fishClassEnum != FishClassEnum.PLANT) {
                    ref.read(fishUpdateProvider.notifier).notifyFishClassEnum(FishClassEnum.PLANT);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "수초", isChecked: fishClassEnum == FishClassEnum.PLANT),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
