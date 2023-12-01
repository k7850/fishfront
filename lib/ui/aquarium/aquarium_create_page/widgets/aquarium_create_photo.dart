import 'dart:io';

import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/aquarium_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AquariumCreatePhoto extends ConsumerWidget {
  const AquariumCreatePhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AquariumCreateModel model = ref.watch(aquariumCreateProvider)!;

    // AquariumDTO aquariumDTO = model.aquariumDTO;

    File? imageFile = model.imageFile;

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
                  "assets/aquarium.png",
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
              ref.read(aquariumCreateProvider.notifier).notifyImageFile(File(image.path));
            },
            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 10))),
            child: const Text("사진 변경"),
          ),
        ),
      ],
    );
  }
}
