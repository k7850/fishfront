import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/aquarium_create_page.dart';
import 'package:fishfront/ui/aquarium/detail_tabbar_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/aquarium/main_page/widgets/aquarium_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainBody extends ConsumerWidget {
  List<AquariumDTO> aquariumDTOList;
  MainBody(this.aquariumDTOList, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("메인페이지 빌드됨");

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    aquariumDTOList.length + 1,
                    (index) {
                      return index == aquariumDTOList.length
                          ? const SizedBox(width: 20)
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
            const SizedBox(height: 20),
          ],
        ),
        Container(
          padding: const EdgeInsets.only(right: 15, bottom: 10),
          alignment: const Alignment(1, 1),
          child: FloatingActionButton(
            onPressed: () {
              print("어항추가버튼");
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AquariumCreatePage()));
            },
            child: const Icon(Icons.add, size: 35),
          ),
        ),
      ],
    );
  }
}
