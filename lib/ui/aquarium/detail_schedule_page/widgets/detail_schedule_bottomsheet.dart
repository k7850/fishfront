import 'dart:convert';
import 'dart:io';

import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/diary_dto.dart';
import 'package:fishfront/data/dto/diary_request_dto.dart';
import 'package:fishfront/ui/aquarium/detail_diary_page/detail_diary_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailScheduleBottomsheet extends ConsumerWidget {
  const DetailScheduleBottomsheet(
    this.diaryId, {
    super.key,
  });

  final int diaryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("DetailDiaryBottomsheet빌드됨");

    DetailScheduleModel model = ref.watch(detailScheduleProvider)!;

    DiaryDTO diaryDTO = model.aquariumDTO.diaryDTOList.firstWhere((element) => element.id == diaryId);

    return Container(
      // height: 580,
      color: Colors.transparent,
      // padding: EdgeInsets.only(left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Text("${DateFormat.yMMMMd("ko").format(diaryDTO.createdAt)} 기록", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
            diaryDTO.title != null && diaryDTO.title!.isEmpty
                ? const SizedBox()
                : Container(
                    alignment: const Alignment(-1, 0),
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text("${diaryDTO.title}", style: const TextStyle(fontSize: 20, color: Colors.black, fontFamily: "Giants")),
                  ),
            diaryDTO.text != null && diaryDTO.text!.isEmpty
                ? const SizedBox()
                : Container(
                    decoration: BoxDecoration(color: const Color.fromRGBO(210, 210, 210, 1), borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                    alignment: const Alignment(-1, 0),
                    child: Text("${diaryDTO.text}", style: TextStyle(color: Colors.grey[600])),
                  ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: diaryDTO.photo != null && diaryDTO.photo!.isNotEmpty
                  ? Image.network(
                      "$imageURL${diaryDTO.photo!}",
                      width: 500,
                      height: 280,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
