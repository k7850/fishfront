import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/main/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class DetailFishBody extends ConsumerStatefulWidget {
  @override
  _DetailFishBodyState createState() => _DetailFishBodyState();
}

class _DetailFishBodyState extends ConsumerState<DetailFishBody> {
  @override
  Widget build(BuildContext context) {
    print("빌드됨");

    MainModel? model = ref.watch(mainProvider);
    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    ParamStore paramStore = ref.read(paramProvider);

    AquariumDTO aquariumDTO = model.aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    List<FishDTO> onlyFishList = [];
    List<FishDTO> onlyPlantList = [];
    List<FishDTO> onlyOtherList = [];

    aquariumDTO.fishDTOList.forEach((fishDTO) {
      if (fishDTO.fishClassEnum == "OTHER") {
        onlyOtherList.add(fishDTO);
      } else if (fishDTO.fishClassEnum == "PLANT") {
        onlyPlantList.add(fishDTO);
      } else {
        onlyFishList.add(fishDTO);
      }
    });

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text("물고기", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                SizedBox(height: 10),
                for (FishDTO fishDTO in onlyFishList) AquariumFishItem(fishDTO: fishDTO),
                SizedBox(height: 5),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text("기타 생물", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                SizedBox(height: 10),
                for (FishDTO fishDTO in onlyOtherList) AquariumFishItem(fishDTO: fishDTO),
                SizedBox(height: 5),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text("수초", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                SizedBox(height: 10),
                for (FishDTO fishDTO in onlyPlantList) AquariumFishItem(fishDTO: fishDTO),
                SizedBox(height: 5),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              print("fffff");
            },
            child: Text("생물 추가"),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class AquariumFishItem extends StatelessWidget {
  const AquariumFishItem({
    super.key,
    required this.fishDTO,
  });

  final FishDTO fishDTO;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "${imageURL}${fishDTO.photo}",
                width: sizeGetScreenWidth(context) * 0.2,
                height: sizeGetScreenWidth(context) * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.45),
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
                          text: "${fishDTO.quantity != null ? ", x${fishDTO.quantity}" : ""})",
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
              onTap: () {},
              child: Icon(Icons.copy_sharp, size: 25),
            ),
            InkWell(
              onTap: () {},
              child: Icon(Icons.delete_outline, size: 30, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
