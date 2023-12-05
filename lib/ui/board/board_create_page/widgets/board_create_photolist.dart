import 'dart:io';

import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../_core/constants/size.dart';

class BoardCreatePhotoList extends ConsumerWidget {
  const BoardCreatePhotoList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    BoardCreateModel model = ref.watch(boardCreateProvider)!;
    List<File>? imageFileList = model.imageFileList;

    if (imageFileList == null) return const SizedBox();

    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: new PageController(viewportFraction: 0.93),
        pageSnapping: true,
        itemCount: imageFileList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Stack(
              alignment: const Alignment(0.9, 0.9),
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    imageFileList[index],
                    height: 300,
                    width: sizeGetScreenWidth(context),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                  child: Text(
                    "${index + 1} / ${imageFileList.length}",
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
