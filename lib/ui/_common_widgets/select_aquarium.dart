import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../_core/constants/http.dart';
import '../../_core/constants/size.dart';
import '../../data/dto/aquarium_dto.dart';
import '../../data/dto/fish_dto.dart';
import '../aquarium/main_page/main_view_model.dart';

class SelectAquarium extends ConsumerWidget {
  const SelectAquarium({
    this.fishDTO,
    this.book,
    required this.mainText,
    super.key,
  });

  final FishDTO? fishDTO;
  final Book? book;
  final String mainText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;

    return AlertDialog(
      title: RichText(
        text: TextSpan(
          text: mainText,
          style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
          children: const [
            TextSpan(text: " 소속시킬 어항", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "")),
          ],
        ),
      ),
      content: SizedBox(
        height: 5 + aquariumDTOList.length * 75,
        child: Column(
          children: [
            for (AquariumDTO aquariumDTO in aquariumDTOList)
              Column(
                children: [
                  const Divider(color: Colors.grey, height: 1, thickness: 1),
                  const SizedBox(height: sizeS5),
                  InkWell(
                    onTap: () async {
                      if (aquariumDTO.id == fishDTO?.aquariumId) {
                        print("현재소속어항임");
                        return;
                      }
                      print("${aquariumDTO.title}");
                      Navigator.pop(context);
                      if (book != null) {
                        FishRequestDTO fishRequestDTO =
                            FishRequestDTO(fishClassEnum: book!.fishClassEnum ?? FishClassEnum.FISH, name: book!.normalName, bookId: book!.id);
                        await ref.read(mainProvider.notifier).notifyFishCreate(aquariumDTO.id, fishRequestDTO, null);
                      }
                      if (fishDTO != null) {
                        await ref.read(mainProvider.notifier).notifyFishMove(fishDTO!, aquariumDTO.id);
                      }
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "$imageURL${aquariumDTO.photo}",
                            width: sizeGetScreenWidth(context) * 0.2,
                            height: sizeGetScreenWidth(context) * 0.15,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/aquarium.png",
                                width: sizeGetScreenWidth(context) * 0.2,
                                height: sizeGetScreenWidth(context) * 0.15,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: sizeM10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(aquariumDTO.title, style: const TextStyle(fontSize: 18, fontFamily: "Giants")),
                            aquariumDTO.id == fishDTO?.aquariumId
                                ? Text("현재 소속 어항", style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
                                : const SizedBox(),
                          ],
                        ),
                        const Spacer(),
                        aquariumDTO.id == fishDTO?.aquariumId
                            ? const Text("X ", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
                            : const Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                      ],
                    ),
                  ),
                  const SizedBox(height: sizeS5),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
