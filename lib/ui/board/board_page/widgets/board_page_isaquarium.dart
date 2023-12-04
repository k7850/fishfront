import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardPageIsAquarium extends ConsumerWidget {
  const BoardPageIsAquarium({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool? isAquarium = ref.watch(boardProvider)!.isAquarium;

    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (isAquarium != null) ref.read(boardProvider.notifier).notifyIsAquarium(null);
            },
            child: MyCheckbox(str: "전체", isChecked: isAquarium == null),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (isAquarium != true) ref.read(boardProvider.notifier).notifyIsAquarium(true);
            },
            child: MyCheckbox(str: "어항", isChecked: isAquarium == true),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (isAquarium != false) ref.read(boardProvider.notifier).notifyIsAquarium(false);
            },
            child: MyCheckbox(str: "생물", isChecked: isAquarium == false),
          ),
        ],
      ),
    );
  }
}
