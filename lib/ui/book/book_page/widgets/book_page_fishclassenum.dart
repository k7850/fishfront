import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../book_view_model.dart';

class BookPageFishclassenum extends ConsumerWidget {
  const BookPageFishclassenum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FishClassEnum fishClassEnum = ref.watch(bookProvider)!.fishClassEnum;

    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              fishClassEnum != FishClassEnum.FISH
                  ? ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.FISH)
                  : ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.ALL);
              // setState(() {});
            },
            child: MyCheckbox(str: "물고기", isChecked: fishClassEnum == FishClassEnum.FISH),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              fishClassEnum != FishClassEnum.OTHER
                  ? ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.OTHER)
                  : ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.ALL);
              // setState(() {});
            },
            child: MyCheckbox(str: "기타 생물", isChecked: fishClassEnum == FishClassEnum.OTHER),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              fishClassEnum != FishClassEnum.PLANT
                  ? ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.PLANT)
                  : ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.ALL);
              // setState(() {});
            },
            child: MyCheckbox(str: "수초", isChecked: fishClassEnum == FishClassEnum.PLANT),
          ),
        ],
      ),
    );
  }
}
