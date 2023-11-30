import 'dart:io';

import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DetailOtherPhoto extends ConsumerWidget {
  const DetailOtherPhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailOtherModel model = ref.watch(detailOtherProvider)!;

    AquariumDTO aquariumDTO = model.aquariumDTO;

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
              : Image.network(
                  "$imageURL${aquariumDTO.photo}",
                  width: sizeGetScreenWidth(context),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/aquarium.png",
                      width: sizeGetScreenWidth(context),
                      fit: BoxFit.cover,
                    );
                  },
                ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 5, right: 10),
          child: ElevatedButton(
            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image == null) return;
              ref.read(detailOtherProvider.notifier).notifyImageFile(File(image.path));
            },
            style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 10))),
            child: const Text("사진 변경"),
          ),
        ),
      ],
    );
  }
}
