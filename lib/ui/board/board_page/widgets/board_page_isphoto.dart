import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardPageIsPhoto extends ConsumerWidget {
  const BoardPageIsPhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool? isPhoto = ref.watch(boardProvider)!.isPhoto;

    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if (isPhoto != null) ref.read(boardProvider.notifier).notifyIsPhoto(null);
            },
            child: MyCheckbox(str: "전체", isChecked: isPhoto == null),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (isPhoto != true) ref.read(boardProvider.notifier).notifyIsPhoto(true);
            },
            child: MyCheckbox(str: "사진", isChecked: isPhoto == true),
          ),
          const SizedBox(width: 20),
          InkWell(
            onTap: () {
              if (isPhoto != false) ref.read(boardProvider.notifier).notifyIsPhoto(false);
            },
            child: MyCheckbox(str: "동영상", isChecked: isPhoto == false),
          ),
        ],
      ),
    );
  }
}
