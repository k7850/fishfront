import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../book_view_model.dart';

class BookPageIsfreshwater extends ConsumerWidget {
  const BookPageIsfreshwater({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool? isFreshWater = ref.watch(bookProvider)!.isFreshWater;

    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              isFreshWater == true
                  ? ref.read(bookProvider.notifier).notifyIsFreshWater(null)
                  : ref.read(bookProvider.notifier).notifyIsFreshWater(true);
              // setState(() {});
            },
            child: MyCheckbox(str: "담수 어항", isChecked: isFreshWater == true),
          ),
          const SizedBox(width: 30),
          InkWell(
            onTap: () {
              isFreshWater == false
                  ? ref.read(bookProvider.notifier).notifyIsFreshWater(null)
                  : ref.read(bookProvider.notifier).notifyIsFreshWater(false);
              // setState(() {});
            },
            child: MyCheckbox(str: "해수 어항", isChecked: isFreshWater == false),
          ),
        ],
      ),
    );
  }
}
