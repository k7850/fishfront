import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../book_view_model.dart';

class BookPageIsfreshwater extends ConsumerWidget {
  const BookPageIsfreshwater({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool? isFreshWater = ref.watch(bookProvider)!.isFreshWater;

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (isFreshWater == true) {
                ref.read(bookProvider.notifier).notifyIsFreshWater(null);
              } else {
                ref.read(bookProvider.notifier).notifyIsFreshWater(true);
              }
              // setState(() {});
            },
            child: Row(
              children: [
                isFreshWater == true ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                SizedBox(width: 5),
                Container(
                  child: Text("담수 어항",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: isFreshWater == true ? Colors.black : Colors.grey[600],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(width: 30),
          InkWell(
            onTap: () {
              if (isFreshWater == false) {
                ref.read(bookProvider.notifier).notifyIsFreshWater(null);
              } else {
                ref.read(bookProvider.notifier).notifyIsFreshWater(false);
              }
              // setState(() {});
            },
            child: Row(
              children: [
                isFreshWater == false ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                SizedBox(width: 5),
                Container(
                  child: Text("해수 어항",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: isFreshWater == false ? Colors.black : Colors.grey[600],
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
