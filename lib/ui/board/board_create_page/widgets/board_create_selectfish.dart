import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:fishfront/ui/board/board_create_page/board_create_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectFish extends ConsumerWidget {
  const SelectFish({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;

    List<FishDTO> fishDTOList = [];

    for (AquariumDTO aquariumDTO in aquariumDTOList) {
      fishDTOList.addAll(aquariumDTO.fishDTOList);
    }

    return AlertDialog(
      title: RichText(
        text: const TextSpan(
          text: "연동 ",
          style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
          children: [
            TextSpan(text: "생물 선택", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "JamsilRegular")),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            for (AquariumDTO aquariumDTO in aquariumDTOList)
              Column(
                children: [
                  const Divider(color: Colors.grey, height: 1, thickness: 1),
                  const SizedBox(height: 10),
                  Text(aquariumDTO.title, style: TextStyle(fontSize: 20, color: Colors.grey[700])),
                  for (FishDTO fishDTO in aquariumDTO.fishDTOList)
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        InkWell(
                          onTap: () async {
                            print("${fishDTO.name}");
                            Navigator.pop(context);
                            await ref.read(boardCreateProvider.notifier).notifySelectFishDTO(fishDTO);
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: fishDTO.photo != null && fishDTO.photo!.isNotEmpty
                                    ? Image.network(
                                        "$imageURL${fishDTO.photo}",
                                        width: sizeGetScreenWidth(context) * 0.14,
                                        height: sizeGetScreenWidth(context) * 0.1,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            "assets/fish.png",
                                            width: sizeGetScreenWidth(context) * 0.14,
                                            height: sizeGetScreenWidth(context) * 0.1,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : fishDTO.book != null
                                        ? Image.network(
                                            "$imageURL${fishDTO.book!.photo}",
                                            width: sizeGetScreenWidth(context) * 0.14,
                                            height: sizeGetScreenWidth(context) * 0.1,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                "assets/fish.png",
                                                width: sizeGetScreenWidth(context) * 0.14,
                                                height: sizeGetScreenWidth(context) * 0.1,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          )
                                        : Image.asset(
                                            "assets/fish.png",
                                            width: sizeGetScreenWidth(context) * 0.14,
                                            height: sizeGetScreenWidth(context) * 0.1,
                                            fit: BoxFit.cover,
                                          ),
                              ),
                              const SizedBox(width: sizeM10),
                              Text("${fishDTO.name} ", style: const TextStyle(fontSize: 15)),
                              Text(
                                fishDTO.book == null ? "" : "(${fishDTO.book!.normalName})",
                                style: TextStyle(fontSize: 12, color: Colors.grey[700], fontFamily: "JamsilRegular"),
                              ),
                              const Spacer(),
                              const Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
