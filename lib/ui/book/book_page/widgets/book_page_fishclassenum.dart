import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../book_view_model.dart';

class BookPageFishclassenum extends ConsumerWidget {
  const BookPageFishclassenum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String fishClassEnum = ref.watch(bookProvider)!.fishClassEnum;

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (fishClassEnum != "FISH") {
                ref.read(bookProvider.notifier).notifyFishClassEnum("FISH");
              } else {
                ref.read(bookProvider.notifier).notifyFishClassEnum("");
              }
              // setState(() {});
            },
            child: Row(
              children: [
                fishClassEnum == "FISH" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                SizedBox(width: 5),
                Container(
                  child: Text("물고기",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: fishClassEnum == "FISH" ? Colors.black : Colors.grey[600],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (fishClassEnum != "OTHER") {
                ref.read(bookProvider.notifier).notifyFishClassEnum("OTHER");
              } else {
                ref.read(bookProvider.notifier).notifyFishClassEnum("");
              }
              // setState(() {});
            },
            child: Row(
              children: [
                fishClassEnum == "OTHER" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                SizedBox(width: 5),
                Container(
                  child: Text("기타 생물",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: fishClassEnum == "OTHER" ? Colors.black : Colors.grey[600],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (fishClassEnum != "PLANT") {
                ref.read(bookProvider.notifier).notifyFishClassEnum("PLANT");
              } else {
                ref.read(bookProvider.notifier).notifyFishClassEnum("");
              }
              // setState(() {});
            },
            child: Row(
              children: [
                fishClassEnum == "PLANT" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                SizedBox(width: 5),
                Container(
                  child: Text("수초",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: fishClassEnum == "PLANT" ? Colors.black : Colors.grey[600],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
