import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/_common_widgets/my_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/aquarium/diary_create_page/diary_create_body.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/fish_create_body.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_body.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryCreatePage extends ConsumerStatefulWidget {
  const DiaryCreatePage({Key? key}) : super(key: key);

  @override
  _DiaryCreatePageState createState() => _DiaryCreatePageState();
}

class _DiaryCreatePageState extends ConsumerState<DiaryCreatePage> {
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "기록 작성", onTapFunction: () {}),
      bottomNavigationBar: const MyBottom(),
      body: const DiaryCreateBody(),
    );
  }
}
