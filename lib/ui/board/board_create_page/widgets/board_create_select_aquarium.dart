import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/_common_widgets/select_aquarium.dart';
import 'package:flutter/material.dart';

class BoardCreateSelectAquarium extends StatelessWidget {
  const BoardCreateSelectAquarium({
    super.key,
    required this.aquariumDTO,
  });

  final AquariumDTO? aquariumDTO;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return const SelectAquarium(mainText: "연동");
          },
        );
      },
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color.fromRGBO(210, 210, 210, 1)),
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: Text(aquariumDTO == null ? "" : aquariumDTO!.title, style: const TextStyle(fontSize: 17)),
          ),
        ],
      ),
    );
  }
}
