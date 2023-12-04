// import 'package:fishfront/_core/constants/http.dart';
// import 'package:fishfront/_core/constants/size.dart';
// import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../../data/dto/aquarium_dto.dart';
// import '../fish_create_view_model.dart';
//
// class FishCreateAlertdialog extends ConsumerWidget {
//   const FishCreateAlertdialog({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     FishCreateModel model = ref.watch(fishCreateProvider)!;
//
//     // FishDTO fishDTO = model.fishDTO;
//     AquariumDTO aquariumDTO = model.aquariumDTO;
//
//     List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;
//
//     return AlertDialog(
//       title: RichText(
//         text: TextSpan(
//           text: model.name.text,
//           style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
//           children: const [
//             TextSpan(text: " 소속시킬 어항", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "")),
//           ],
//         ),
//       ),
//       content: SizedBox(
//         height: 5 + aquariumDTOList.length * 75,
//         child: Column(
//           children: [
//             for (AquariumDTO listAquariumDTO in aquariumDTOList)
//               Column(
//                 children: [
//                   const Divider(color: Colors.grey, height: 1, thickness: 1),
//                   const SizedBox(height: sizeS5),
//                   InkWell(
//                     onTap: () async {
//                       if (listAquariumDTO.id == aquariumDTO.id) {
//                         print("현재소속어항임");
//                         return;
//                       }
//                       print("${listAquariumDTO.title}");
//                       // aquariumDTO = listAquariumDTO;
//                       ref.read(fishCreateProvider.notifier).notifyAquariumDTO(listAquariumDTO);
//                       Navigator.pop(context);
//                       // setState(() {});
//                     },
//                     child: Row(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             "$imageURL${listAquariumDTO.photo}",
//                             width: sizeGetScreenWidth(context) * 0.2,
//                             height: sizeGetScreenWidth(context) * 0.15,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Image.asset(
//                                 "assets/aquarium.png",
//                                 width: sizeGetScreenWidth(context) * 0.2,
//                                 height: sizeGetScreenWidth(context) * 0.15,
//                                 fit: BoxFit.cover,
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(width: sizeM10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(listAquariumDTO.title, style: const TextStyle(fontSize: 18, fontFamily: "Giants")),
//                             listAquariumDTO.id == aquariumDTO.id
//                                 ? Text("현재 소속 어항", style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
//                                 : const SizedBox(),
//                           ],
//                         ),
//                         const Spacer(),
//                         listAquariumDTO.id == aquariumDTO.id
//                             ? const Text("X ", style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
//                             : const Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: sizeS5),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
