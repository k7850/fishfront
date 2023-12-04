import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_request_dto.dart';
import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_day_inkwell.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_week_inkwell.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/event.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleButton extends ConsumerWidget {
  const DetailScheduleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailScheduleModel? model = ref.watch(detailScheduleProvider)!;

    TextEditingController _eventController = model.eventController;

    DateTime selectedDay = model.selectedDay;

    Map<DateTime, List<Event>> eventMap = model.eventMap;

    List<Event> selectedEventList = model.selectedEventList;

    AquariumDTO aquariumDTO = model.aquariumDTO;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))),
          onPressed: () {
            _eventController.text = "";
            showDialog(
              context: context,
              builder: (context) {
                int importantly = 1;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      scrollable: true,
                      title: Text("${selectedDay.month}월 ${selectedDay.day}일 계획 추가"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("중요도"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => setState(() => importantly = 1),
                                child: MyCheckbox(str: "낮음", isChecked: importantly == 1 ? true : false, color: Colors.black),
                              ),
                              InkWell(
                                onTap: () => setState(() => importantly = 2),
                                child: MyCheckbox(str: "중간", isChecked: importantly == 2 ? true : false, color: Colors.green),
                              ),
                              InkWell(
                                onTap: () => setState(() => importantly = 3),
                                child: MyCheckbox(str: "높음", isChecked: importantly == 3 ? true : false, color: Colors.redAccent),
                              ),
                            ],
                          ),
                          TextField(autofocus: true, controller: _eventController),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
                          onPressed: () async {
                            if (_eventController.text == "") {
                              return;
                            }

                            ScheduleRequestDTO scheduleRequestDTO = new ScheduleRequestDTO(
                                title: _eventController.text, scheduleEnum: "지정", targetDay: selectedDay, importantly: importantly);

                            await ref.watch(mainProvider.notifier).notifyScheduleCreate(aquariumDTO.id, scheduleRequestDTO);

                            eventMap[selectedDay] ??= [];
                            eventMap[selectedDay]!.add(Event(title: _eventController.text));

                            selectedEventList = eventMap[selectedDay] ?? [];
                            // ref.read(detailScheduleProvider.notifier).notifySelectedEventList(selectedEventList);
                            ref.read(detailScheduleProvider.notifier).notifyInit();
                            // setState(() {});
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AquariumDetailPage()));

                            Navigator.pop(context);
                            print("다시그림");
                          },
                          child: Text("제출"),
                        ),
                        SizedBox(width: 5),
                      ],
                    );
                  },
                );
              },
            );
          },
          child: Text(
              "${selectedDay.month < 10 ? "0${selectedDay.month}" : selectedDay.month}월 ${selectedDay.day < 10 ? "0${selectedDay.day}" : selectedDay.day}일 계획"),
        ),
        ElevatedButton(
          child: const Text("요일 반복 계획"),
          style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))),
          onPressed: () {
            _eventController.text = "";
            showDialog(
              context: context,
              builder: (context) {
                int importantly = 1;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text("요일 반복 계획 추가"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("중요도"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => setState(() => importantly = 1),
                                child: MyCheckbox(str: "낮음", isChecked: importantly == 1 ? true : false, color: Colors.black),
                              ),
                              InkWell(
                                onTap: () => setState(() => importantly = 2),
                                child: MyCheckbox(str: "중간", isChecked: importantly == 2 ? true : false, color: Colors.green),
                              ),
                              InkWell(
                                onTap: () => setState(() => importantly = 3),
                                child: MyCheckbox(str: "높음", isChecked: importantly == 3 ? true : false, color: Colors.redAccent),
                              ),
                            ],
                          ),
                          TextField(autofocus: true, controller: _eventController),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DetailScheduleWeekInkwell("일", 7, importantly),
                            DetailScheduleWeekInkwell("월", 1, importantly),
                            DetailScheduleWeekInkwell("화", 2, importantly),
                            DetailScheduleWeekInkwell("수", 3, importantly),
                            DetailScheduleWeekInkwell("목", 4, importantly),
                            DetailScheduleWeekInkwell("금", 5, importantly),
                            DetailScheduleWeekInkwell("토", 6, importantly),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
        ElevatedButton(
          child: const Text("기간 반복 계획"),
          style: const ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 10))),
          onPressed: () {
            _eventController.text = "";
            showDialog(
              context: context,
              builder: (context) {
                int importantly = 1;
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text("기간 반복 계획 추가"),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("중요도"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => setState(() => importantly = 1),
                                child: MyCheckbox(str: "낮음", isChecked: importantly == 1 ? true : false, color: Colors.black),
                              ),
                              InkWell(
                                onTap: () => setState(() => importantly = 2),
                                child: MyCheckbox(str: "중간", isChecked: importantly == 2 ? true : false, color: Colors.green),
                              ),
                              InkWell(
                                onTap: () => setState(() => importantly = 3),
                                child: MyCheckbox(str: "높음", isChecked: importantly == 3 ? true : false, color: Colors.redAccent),
                              ),
                            ],
                          ),
                          TextField(autofocus: true, controller: _eventController),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DetailScheduleDayInkwell("매일", 1, importantly),
                            DetailScheduleDayInkwell("격일", 2, importantly),
                            DetailScheduleDayInkwell("나흘", 4, importantly),
                            DetailScheduleDayInkwell("열흘", 10, importantly),
                            DetailScheduleDayInkwell("매월", 30, importantly),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
