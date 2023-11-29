import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../_core/constants/enum.dart';
import '../../../../../_core/constants/http.dart';
import '../../../../../_core/constants/size.dart';
import '../../../../../_core/utils/validator_util.dart';
import '../../../../../data/dto/aquarium_dto.dart';
import '../../../../../data/dto/fish_dto.dart';
import '../../../../_common_widgets/aquarium_textformfield.dart';
import '../../../main_page/main_view_model.dart';
import '../fish_update_view_model.dart';

class FishUpdateImportant extends ConsumerStatefulWidget {
  const FishUpdateImportant({
    super.key,
  });

  @override
  _FishUpdateImportantState createState() => _FishUpdateImportantState();
}

class _FishUpdateImportantState extends ConsumerState<FishUpdateImportant> {
  @override
  Widget build(BuildContext context) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    FishDTO fishDTO = model.fishDTO;
    AquariumDTO aquariumDTO = model.aquariumDTO;

    TextEditingController _name = model.name;

    FishClassEnum fishClassEnum = model.fishClassEnum;

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("필수 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          AquariumTextFormField("생물 이름", _name, validateNormal(), (String value) => ref.read(fishUpdateProvider.notifier).notifyName(value)),
          Container(
            alignment: const Alignment(-1, 0),
            padding: const EdgeInsets.only(bottom: 5),
            child: Text("소속 어항", style: TextStyle(color: Colors.grey[600])),
          ),
          InkWell(
            onTap: () {
              print("소속어항");
              ScaffoldMessenger.of(context).clearSnackBars();
              List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: RichText(
                      text: TextSpan(
                        text: "${fishDTO.name}",
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
                          for (AquariumDTO listAquariumDTO in aquariumDTOList)
                            Column(
                              children: [
                                const Divider(color: Colors.grey, height: 1, thickness: 1),
                                const SizedBox(height: sizeS5),
                                InkWell(
                                  onTap: () async {
                                    if (listAquariumDTO.id == aquariumDTO.id) {
                                      print("현재소속어항임");
                                      return;
                                    }
                                    print("${listAquariumDTO.title}");
                                    // aquariumDTO = listAquariumDTO;
                                    ref.read(fishUpdateProvider.notifier).notifyAquariumDTO(listAquariumDTO);
                                    Navigator.pop(context);
                                    // setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          "${imageURL}${listAquariumDTO.photo}",
                                          width: sizeGetScreenWidth(context) * 0.2,
                                          height: sizeGetScreenWidth(context) * 0.15,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: sizeM10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${listAquariumDTO.title}", style: TextStyle(fontSize: 18, fontFamily: "Giants")),
                                          listAquariumDTO.id == aquariumDTO.id
                                              ? Text("현재 소속 어항", style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
                                              : SizedBox(),
                                        ],
                                      ),
                                      Spacer(),
                                      listAquariumDTO.id == fishDTO.aquariumId
                                          ? Text("X ",
                                              style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
                                          : Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                SizedBox(height: sizeS5),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text("${aquariumDTO.title}", style: TextStyle(fontSize: 17)),
                ),
                const Divider(color: Colors.black38, height: 1, thickness: 1),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 5),
            alignment: const Alignment(-1, 0),
            child: Text("생물 종류", style: TextStyle(color: Colors.grey[600])),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (fishClassEnum != FishClassEnum.FISH) {
                    ref.read(fishUpdateProvider.notifier).notifyFishClassEnum(FishClassEnum.FISH);
                    // setState(() {});
                  }
                },
                child: Row(
                  children: [
                    fishClassEnum == FishClassEnum.FISH ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                    SizedBox(width: 5),
                    Container(
                      child: Text("물고기",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: fishClassEnum == FishClassEnum.FISH ? Colors.black : Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (fishClassEnum != FishClassEnum.OTHER) {
                    ref.read(fishUpdateProvider.notifier).notifyFishClassEnum(FishClassEnum.OTHER);
                    // setState(() {});
                  }
                },
                child: Row(
                  children: [
                    fishClassEnum == FishClassEnum.OTHER ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                    SizedBox(width: 5),
                    Container(
                      child: Text("기타 생물",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: fishClassEnum == FishClassEnum.OTHER ? Colors.black : Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (fishClassEnum != FishClassEnum.PLANT) {
                    ref.read(fishUpdateProvider.notifier).notifyFishClassEnum(FishClassEnum.PLANT);
                    // setState(() {});
                  }
                },
                child: Row(
                  children: [
                    fishClassEnum == FishClassEnum.PLANT ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                    SizedBox(width: 5),
                    Container(
                      child: Text("수초",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: fishClassEnum == FishClassEnum.PLANT ? Colors.black : Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
