import 'dart:io';

import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/_common_widgets/aquarium_textformfield.dart';
import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:fishfront/ui/aquarium/detail_other_page/detail_other_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishfront/_core/utils/validator_util.dart';

class DetailOtherInform extends ConsumerWidget {
  const DetailOtherInform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailOtherModel model = ref.watch(detailOtherProvider)!;

    TextEditingController _title = model.title;
    TextEditingController _intro = model.intro;

    bool isFreshWater = model.isFreshWater;

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("어항 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          AquariumTextFormField("어항 이름", _title, validateNormal(), (String value) => ref.read(detailOtherProvider.notifier).notifyTitle(value)),
          AquariumTextFormField(
              isLong: true, "메모하기", _intro, validateLong(), (String value) => ref.read(detailOtherProvider.notifier).notifyIntro(value)),
          Container(
            alignment: const Alignment(-1, 0),
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("어항 종류", style: TextStyle(color: Colors.grey[600])),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (isFreshWater == false) {
                    ref.read(detailOtherProvider.notifier).notifyIsFreshWater(true);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "담수 어항", isChecked: isFreshWater),
              ),
              const SizedBox(width: 30),
              InkWell(
                onTap: () {
                  if (isFreshWater == true) {
                    ref.read(detailOtherProvider.notifier).notifyIsFreshWater(false);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "해수 어항", isChecked: !isFreshWater),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
