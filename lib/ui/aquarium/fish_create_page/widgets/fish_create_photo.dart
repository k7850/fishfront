import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../_core/constants/http.dart';
import '../../../../../_core/constants/size.dart';
import '../../../../../data/model/book.dart';
import '../fish_create_view_model.dart';

class FishCreatePhoto extends ConsumerWidget {
  const FishCreatePhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FishCreateModel model = ref.watch(fishCreateProvider)!;

    // FishDTO fishDTO = model.fishDTO;
    File? imageFile = model.imageFile;
    Book? book = model.book;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: imageFile != null
              ? Image.file(
                  imageFile,
                  width: sizeGetScreenWidth(context),
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  "assets/fish.png",
                  width: sizeGetScreenWidth(context),
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5, right: 10),
          child: ElevatedButton(
            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image == null) return;
              ref.read(fishCreateProvider.notifier).notifyImageFile(File(image.path));
              // imageFile = File(image.path);
              // setState(() {});
            },
            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 10))),
            child: const Text("사진 변경"),
          ),
        ),
      ],
    );
  }
}
