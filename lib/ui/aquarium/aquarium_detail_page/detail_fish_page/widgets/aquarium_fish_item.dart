import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/fish_update_page/fish_update_body.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/fish_update_page/fish_update_page.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../_core/constants/http.dart';
import '../../../../../_core/constants/size.dart';
import '../../../../../data/dto/fish_dto.dart';

class AquariumFishItem extends StatelessWidget {
  const AquariumFishItem({super.key, required this.fishDTO, required this.ref});

  final FishDTO fishDTO;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("fishDTO.id : ${fishDTO.id}");
        ParamStore paramStore = ref.read(paramProvider);
        paramStore.addFishDetailId(fishDTO.id);
        print("paramStore.addFishDetailId : ${paramStore.addFishDetailId}");
        Navigator.push(context, MaterialPageRoute(builder: (_) => FishUpdatePage()));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Hero(
              tag: "fishphotohero${fishDTO.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fishDTO.photo != null && fishDTO.photo!.isNotEmpty
                      ? "${imageURL}${fishDTO.photo}"
                      : fishDTO.book == null || fishDTO.book!.photo == null
                          ? ""
                          : "${imageURL}${fishDTO.book!.photo}",
                  width: sizeGetScreenWidth(context) * 0.2,
                  height: sizeGetScreenWidth(context) * 0.2,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/fish.png",
                      width: sizeGetScreenWidth(context) * 0.2,
                      height: sizeGetScreenWidth(context) * 0.2,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.4),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Giants"),
                      text: "${fishDTO.name} ",
                      children: [
                        TextSpan(
                          text: "(${fishDTO.book?.normalName ?? "불명"}",
                          style: TextStyle(fontSize: 13, fontFamily: "JamsilRegular"),
                        ),
                        TextSpan(
                          text: "${fishDTO.quantity != null && fishDTO.quantity != 0 ? ", x${fishDTO.quantity}" : ""})",
                          style: TextStyle(fontSize: 13, fontFamily: "JamsilRegular"),
                        ),
                      ],
                    ),
                  ),
                ),
                fishDTO.text == null
                    ? SizedBox()
                    : Container(
                        constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.4),
                        child: Text(
                          "${fishDTO.text}",
                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
              ],
            ),
            SizedBox(width: 5),
            Spacer(),
            InkWell(
              onTap: () {
                print("생물이동");
                ScaffoldMessenger.of(context).clearSnackBars();

                List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: RichText(
                        text: TextSpan(
                          text: "${fishDTO.name}",
                          style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
                          children: [
                            TextSpan(text: " 소속시킬 어항", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "")),
                          ],
                        ),
                      ),
                      content: Container(
                        height: 5 + aquariumDTOList.length * 75,
                        child: Column(
                          children: [
                            for (AquariumDTO aquariumDTO in aquariumDTOList)
                              Column(
                                children: [
                                  Divider(color: Colors.grey, height: 1, thickness: 1),
                                  SizedBox(height: sizeS5),
                                  InkWell(
                                    onTap: () async {
                                      if (aquariumDTO.id == fishDTO.aquariumId) {
                                        print("현재소속어항임");
                                        return;
                                      }
                                      print("${aquariumDTO.title}");
                                      await ref.watch(mainProvider.notifier).notifyFishMove(fishDTO, aquariumDTO.id);
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            "${imageURL}${aquariumDTO.photo}",
                                            width: sizeGetScreenWidth(context) * 0.2,
                                            height: sizeGetScreenWidth(context) * 0.15,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: sizeM10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${aquariumDTO.title}", style: TextStyle(fontSize: 18, fontFamily: "Giants")),
                                            aquariumDTO.id == fishDTO.aquariumId
                                                ? Text("현재 소속 어항", style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
                                                : SizedBox(),
                                          ],
                                        ),
                                        Spacer(),
                                        aquariumDTO.id == fishDTO.aquariumId
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
              child: Icon(Icons.logout),
            ),
            SizedBox(width: 3),
            InkWell(
              onTap: () {
                print("생물복제");
                ScaffoldMessenger.of(context).clearSnackBars();
                mySnackbar(
                  3000,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.5),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            text: "${fishDTO.name}",
                            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
                            children: [
                              TextSpan(text: " 복제하시겠습니까?", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "")),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: sizeM10),
                      InkWell(
                        child: Icon(Icons.check, color: Colors.red),
                        onTap: () async {
                          print("스낵바-복제누름");
                          ScaffoldMessenger.of(context).clearSnackBars();
                          await ref.watch(mainProvider.notifier).notifyFishCreate(fishDTO.aquariumId, FishRequestDTO.fromFishDTO(fishDTO), null);
                        },
                      ),
                      SizedBox(width: sizeM10),
                      InkWell(
                        child: Icon(Icons.clear, color: Colors.white),
                        onTap: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.copy_sharp, size: 25, color: Colors.grey[300]),
            ),
            InkWell(
              onTap: () {
                print("생물삭제");
                ScaffoldMessenger.of(context).clearSnackBars();
                mySnackbar(
                  3000,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.5),
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(
                            text: "${fishDTO.name}",
                            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
                            children: [
                              TextSpan(text: " 삭제하시겠습니까?", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "")),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: sizeM10),
                      InkWell(
                        child: Icon(Icons.check, color: Colors.red),
                        onTap: () async {
                          print("스낵바-삭제누름");
                          ScaffoldMessenger.of(context).clearSnackBars();
                          await ref.watch(mainProvider.notifier).notifyFishDelete(fishDTO.id);
                        },
                      ),
                      SizedBox(width: sizeM10),
                      InkWell(
                        child: Icon(Icons.clear, color: Colors.white),
                        onTap: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.delete_outline, size: 30, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
