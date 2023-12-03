import 'package:fishfront/ui/aquarium/detail_schedule_page/detail_schedule_view_model.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_button.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_calendar.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_show_schedule.dart';
import 'package:fishfront/ui/aquarium/detail_schedule_page/widgets/detail_schedule_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailScheduleBody extends ConsumerStatefulWidget {
  const DetailScheduleBody({super.key});

  @override
  _DetailScheduleBodyState createState() => _DetailScheduleBodyState();
}

class _DetailScheduleBodyState extends ConsumerState<DetailScheduleBody> {
  @override
  Widget build(BuildContext context) {
    print("DetailScheduleBody빌드됨");

    DetailScheduleModel? model = ref.watch(detailScheduleProvider);

    if (model == null) {
      ref.read(detailScheduleProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    // return Scaffold(
    //   resizeToAvoidBottomInset: false,-
    //   body:
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
            child: const Column(
              children: [
                DetailScheduleCalendar(), // 달력 부분
                DetailScheduleToggle(), // 일정 보이기/숨기기 토글 버튼
              ],
            ),
          ),
          const SizedBox(height: 15),
          const DetailScheduleShowSchedule(), // 선택한 날짜의 일정
          const SizedBox(height: 10),
          const DetailScheduleButton(), // 스케줄 추가 버튼
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
