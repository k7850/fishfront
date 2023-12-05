import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class BoardCreateFileButtons extends ConsumerWidget {
  const BoardCreateFileButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            child: const Text("사진 등록"),
            onPressed: () async {
              ref.read(boardCreateProvider.notifier).notifyImageFileList(null);
              ref.read(boardCreateProvider.notifier).notifyVideoFile(null);
              final List<XFile> imageList = await ImagePicker().pickMultiImage();
              if (imageList.isEmpty) return;

              List<File> imageFileList = [];
              for (XFile image in imageList) {
                imageFileList.add(File(image.path));
              }

              ref.read(boardCreateProvider.notifier).notifyImageFileList(imageFileList);
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            child: const Text("동영상 등록"),
            onPressed: () async {
              ref.read(boardCreateProvider.notifier).notifyVideoFile(null);
              ref.read(boardCreateProvider.notifier).notifyImageFileList(null);
              XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
              if (video == null) return;
              ref.read(boardCreateProvider.notifier).notifyVideoFile(File(video.path));
            },
          ),
        ),
      ],
    );
  }
}
