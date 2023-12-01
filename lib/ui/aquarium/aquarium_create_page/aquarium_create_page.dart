import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/main.dart';
import 'package:fishfront/ui/_common_widgets/my_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/_common_widgets/my_snackbar.dart';
import 'package:fishfront/ui/aquarium/aquarium_create_page/aquarium_create_body.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/aquarium_detail_tabbar.dart';
import 'package:fishfront/ui/aquarium/main_page/main_body.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AquariumCreatePage extends ConsumerStatefulWidget {
  const AquariumCreatePage({Key? key}) : super(key: key);

  @override
  _AquariumCreatePageState createState() => _AquariumCreatePageState();
}

class _AquariumCreatePageState extends ConsumerState<AquariumCreatePage> {
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "어항 추가", onTapFunction: () {}),
      bottomNavigationBar: const MyBottom(),
      body: const AquariumCreateBody(),
    );
  }
}
