import 'dart:convert';
import 'dart:io';

import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/diary_request_dto.dart';
import 'package:fishfront/ui/aquarium/detail_diary_page/detail_diary_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class DetailDiaryBottomsheet extends ConsumerWidget {
  const DetailDiaryBottomsheet(this._formKey, {super.key});

  final _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("DetailDiaryBottomsheet빌드됨");

    DetailDiaryModel model = ref.watch(detailDiaryProvider)!;

    TextEditingController title = model.title;
    TextEditingController text = model.text;

    File? imageFile = model.imageFile;

    return Container(
      height: 580,
      color: Colors.transparent,
      // padding: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text("기록 작성", style: TextStyle(fontSize: 20, color: Colors.black)),
              const SizedBox(height: 10),
              SizedBox(
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Color.fromRGBO(200, 200, 200, 1),
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                  ),
                  controller: title,
                  validator: (value) {
                    return validateOkEmpty()(value); // String?을 입력으로 받아서 String?을 반환하는 함수를 적어야 함
                  },
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Color.fromRGBO(200, 200, 200, 1),
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                ),
                controller: text,
                validator: (value) {
                  return validateLong()(value); // String?을 입력으로 받아서 String?을 반환하는 함수를 적어야 함
                },
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: imageFile != null
                    ? Image.file(imageFile, width: 500, height: 280, fit: BoxFit.cover)
                    : Image.asset("assets/diary.png", width: 500, height: 280, fit: BoxFit.cover),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Text("사진 등록"),
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      ref.read(detailDiaryProvider.notifier).notifyImageFile(File(image.path));
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    child: const Text("작성 완료"),
                    onPressed: () async {
                      if (imageFile == null && title.text.isEmpty && text.text.isEmpty) return;
                      if (_formKey.currentState!.validate()) {
                        DiaryRequestDTO diaryRequestDTO = DiaryRequestDTO(title: title.text, text: text.text);
                        if (imageFile != null) {
                          List<int> imageBytes = await imageFile.readAsBytes();
                          String base64Image = base64Encode(imageBytes);
                          print("base64Image : ${base64Image}");
                          diaryRequestDTO.base64Image = base64Image;
                        }
                        await ref.watch(mainProvider.notifier).notifyDiaryCreate(diaryRequestDTO);
                        ref.watch(detailDiaryProvider.notifier).notifyInit();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
