import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleToggle extends ConsumerWidget {
  const DetailScheduleToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailScheduleModel model = ref.watch(detailScheduleProvider)!;

    bool toggleFood = model.toggleFood;
    bool toggleWaterChange = model.toggleWaterChange;
    bool toggleImportant = model.toggleImportant;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 5),
          const Divider(color: Colors.grey, height: 1, thickness: 1),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("중요도별 표시 여부", style: TextStyle(color: Colors.grey[600], fontSize: 17)),
              const Spacer(),
              InkWell(
                onTap: () {
                  // print(toggleFood);
                  // toggleFood = !toggleFood;
                  ref.read(detailScheduleProvider.notifier).notifyToggleFood();
                  // setState(() {});
                },
                child: Row(
                  children: [
                    Text(
                      " 낮음 ",
                      style: toggleFood
                          ? TextStyle(color: Colors.grey[600], decoration: TextDecoration.lineThrough, decorationThickness: 3)
                          : const TextStyle(color: Colors.black),
                    ),
                    Container(height: 8, width: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black38)),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  // print(toggleWaterChange);
                  // toggleWaterChange = !toggleWaterChange;
                  ref.read(detailScheduleProvider.notifier).notifyToggleWaterChange();
                  // setState(() {});
                },
                child: Row(
                  children: [
                    Text(
                      " 중간 ",
                      style: toggleWaterChange
                          ? TextStyle(color: Colors.grey[600], decoration: TextDecoration.lineThrough, decorationThickness: 3)
                          : TextStyle(color: Colors.green[600]),
                    ),
                    Container(height: 8, width: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green[600])),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  // print(toggleWaterChange);
                  // toggleWaterChange = !toggleWaterChange;
                  ref.read(detailScheduleProvider.notifier).notifyToggleImportant();
                  // setState(() {});
                },
                child: Row(
                  children: [
                    Text(
                      " 높음 ",
                      style: toggleImportant
                          ? TextStyle(color: Colors.grey[600], decoration: TextDecoration.lineThrough, decorationThickness: 3)
                          : TextStyle(color: Colors.red[300]),
                    ),
                    Container(height: 8, width: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[300])),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
