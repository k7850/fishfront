import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/_common_widgets/select_aquarium.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_page.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../_core/constants/http.dart';
import '../../../_core/constants/size.dart';
import '../../../data/dto/fish_dto.dart';

class AquariumFishItem extends StatelessWidget {
  const AquariumFishItem({super.key, required this.fishDTO, required this.ref});

  final FishDTO fishDTO;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).clearSnackBars();
        print("fishDTO.id : ${fishDTO.id}");
        ParamStore paramStore = ref.read(paramProvider);
        paramStore.addFishDetailId(fishDTO.id);
        print("paramStore.addFishDetailId : ${paramStore.addFishDetailId}");
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FishUpdatePage()));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            buildPhoto(context),
            const SizedBox(width: 10),
            buildText(context),
            const SizedBox(width: 5),
            const Spacer(),
            buildMoveButton(context),
            const SizedBox(width: 3),
            buildCopyButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  InkWell buildDeleteButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print("생물삭제");
        ScaffoldMessenger.of(context).clearSnackBars();
        mySnackbar(
            3000, mySnackbarRowAlert("${fishDTO.name}", "삭제하시겠습니까?", context, () => ref.read(mainProvider.notifier).notifyFishDelete(fishDTO.id)));
      },
      child: const Icon(Icons.delete_outline, size: 30, color: Colors.red),
    );
  }

  InkWell buildCopyButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print("생물복제");
        ScaffoldMessenger.of(context).clearSnackBars();
        mySnackbar(
            3000,
            mySnackbarRowAlert("${fishDTO.name}", "복제하시겠습니까?", context,
                () => ref.read(mainProvider.notifier).notifyFishCreate(fishDTO.aquariumId, FishRequestDTO.fromFishDTO(fishDTO), null)));
      },
      child: Icon(Icons.copy_sharp, size: 25, color: Colors.grey[300]),
    );
  }

  InkWell buildMoveButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print("생물이동");
        ScaffoldMessenger.of(context).clearSnackBars();

        showDialog(
          context: context,
          builder: (context) {
            return SelectAquarium(
              mainText: fishDTO.name ?? "",
              fishDTO: fishDTO,
            );
          },
        );
      },
      child: const Icon(Icons.logout),
    );
  }

  Column buildText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.4),
          child: RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: const TextStyle(fontSize: 17, color: Colors.black, fontFamily: "Giants"),
              text: "${fishDTO.name} ",
              children: [
                TextSpan(
                  text: "(${fishDTO.book?.normalName ?? "불명"}",
                  style: const TextStyle(fontSize: 13, fontFamily: "JamsilRegular"),
                ),
                TextSpan(
                  text: "${fishDTO.quantity != null && fishDTO.quantity != 0 ? ", x${fishDTO.quantity}" : ""})",
                  style: const TextStyle(fontSize: 13, fontFamily: "JamsilRegular"),
                ),
              ],
            ),
          ),
        ),
        fishDTO.text == null
            ? const SizedBox()
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
    );
  }

  Hero buildPhoto(BuildContext context) {
    return Hero(
      tag: "fishphotohero${fishDTO.id}",
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          fishDTO.photo != null && fishDTO.photo!.isNotEmpty
              ? "$imageURL${fishDTO.photo}"
              : fishDTO.book == null || fishDTO.book!.photo == null
                  ? ""
                  : "$imageURL${fishDTO.book!.photo}",
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
    );
  }
}
