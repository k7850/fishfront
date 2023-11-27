import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/main/main_page/widgets/aquarium_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class MainBody extends ConsumerWidget {
  List<AquariumDTO> aquariumDTOList;
  MainBody(this.aquariumDTOList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    aquariumDTOList.length + 1,
                    (index) {
                      return index == aquariumDTOList.length
                          ? SizedBox(width: 20)
                          : InkWell(
                              onTap: () {
                                print("aquariumDTOList[index].id : ${aquariumDTOList[index].id}");
                                ParamStore paramStore = ref.read(paramProvider);
                                paramStore.addAquariumDetailId(aquariumDTOList[index].id);
                                print("paramStore.aquariumDetailId : ${paramStore.aquariumDetailId}");
                                Navigator.push(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));
                              },
                              child: AquariumCard(aquariumDTO: aquariumDTOList[index]),
                            );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
        Container(
          padding: EdgeInsets.only(right: 15, bottom: 10),
          alignment: Alignment(1, 1),
          child: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add, size: 35),
          ),
        ),
      ],
    );
  }
}
