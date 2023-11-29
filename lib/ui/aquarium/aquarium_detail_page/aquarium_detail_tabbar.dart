import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_fish_page/detail_fish_body.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_body.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_schedule_page/detail_schedule_body.dart';
import 'package:flutter/material.dart';

class AquariumDetailTabBar extends StatefulWidget {
  AquariumDTO aquariumDTO;

  AquariumDetailTabBar(this.aquariumDTO);

  @override
  _AquariumDetailTabBarState createState() => _AquariumDetailTabBarState();
}

class _AquariumDetailTabBarState extends State<AquariumDetailTabBar> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(child: Text("일정 관리", style: TextStyle(fontWeight: FontWeight.bold))),
            Tab(child: Text("생물 관리", style: TextStyle(fontWeight: FontWeight.bold))),
            Tab(child: Text("정보 수정", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        Divider(color: Colors.grey, height: 1, thickness: 1),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              DetailScheduleBody(),
              DetailFishBody(),
              DetailOtherBody(),
            ],
          ),
        )
      ],
    );
  }
}
