import 'package:fishfront/_core/constants/enum.dart';
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
              if (fishClassEnum != FishClassEnum.FISH) {
                ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.FISH);
              } else {
                ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.ALL);
              }
              // setState(() {});
            },
            child: Row(
              children: [
                fishClassEnum == FishClassEnum.FISH ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Container(
                  child: Text("물고기",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: fishClassEnum == FishClassEnum.FISH ? Colors.black : Colors.grey[600],
                      )),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (fishClassEnum != FishClassEnum.OTHER) {
                ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.OTHER);
              } else {
                ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.ALL);
              }
              // setState(() {});
            },
            child: Row(
              children: [
                fishClassEnum == FishClassEnum.OTHER ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  "기타 생물",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: fishClassEnum == FishClassEnum.OTHER ? Colors.black : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (fishClassEnum != FishClassEnum.PLANT) {
                ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.PLANT);
              } else {
                ref.read(bookProvider.notifier).notifyFishClassEnum(FishClassEnum.ALL);
              }
              // setState(() {});
            },
            child: Row(
              children: [
                fishClassEnum == FishClassEnum.PLANT ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                const SizedBox(width: 5),
                Text(
                  "수초",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: fishClassEnum == FishClassEnum.PLANT ? Colors.black : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
