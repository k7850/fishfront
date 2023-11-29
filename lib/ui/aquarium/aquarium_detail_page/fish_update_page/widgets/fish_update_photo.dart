import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../_core/constants/http.dart';
import '../../../../../_core/constants/size.dart';
import '../../../../../data/dto/fish_dto.dart';
import '../../../../../data/model/book.dart';
import '../fish_update_view_model.dart';

class FishUpdatePhoto extends ConsumerWidget {
  const FishUpdatePhoto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    FishDTO fishDTO = model.fishDTO;
    File? imageFile = model.imageFile;
    Book? book = model.book;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Hero(
          tag: "fishphotohero${fishDTO.id}",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageFile != null
                ? Image.file(
                    imageFile,
                    width: sizeGetScreenWidth(context),
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    fishDTO.photo != null && fishDTO.photo!.isNotEmpty ? "${imageURL}${fishDTO.photo}" : "${imageURL}${book?.photo}",
                    width: sizeGetScreenWidth(context),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        "assets/fish.png",
                        width: sizeGetScreenWidth(context),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 5, right: 10),
          child: ElevatedButton(
            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image == null) return;
              ref.read(fishUpdateProvider.notifier).notifyImageFile(File(image.path));
              // imageFile = File(image.path);
              // setState(() {});
            },
            style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 10))),
            child: Text("사진 변경"),
          ),
        ),
      ],
    );
  }
}
