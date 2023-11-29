import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_fish_page/widgets/aquarium_fish_item.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
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
    print("DetailFishBody빌드됨");

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
      if (fishDTO.fishClassEnum == FishClassEnum.OTHER) {
        onlyOtherList.add(fishDTO);
      } else if (fishDTO.fishClassEnum == FishClassEnum.PLANT) {
        onlyPlantList.add(fishDTO);
      } else {
        onlyFishList.add(fishDTO);
      }
    });

    onlyFishList.sort((a, b) => a.id.compareTo(b.id));
    onlyPlantList.sort((a, b) => a.id.compareTo(b.id));
    onlyOtherList.sort((a, b) => a.id.compareTo(b.id));

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
                for (FishDTO fishDTO in onlyFishList) AquariumFishItem(fishDTO: fishDTO, ref: ref),
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
                for (FishDTO fishDTO in onlyOtherList) AquariumFishItem(fishDTO: fishDTO, ref: ref),
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
                for (FishDTO fishDTO in onlyPlantList) AquariumFishItem(fishDTO: fishDTO, ref: ref),
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
