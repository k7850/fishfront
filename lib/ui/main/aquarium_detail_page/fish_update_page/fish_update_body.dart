import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/auth/login_page/widgets/custom_login_text_form_field.dart';
import 'package:fishfront/ui/main/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../_common_widgets/aquarium_textformfield.dart';

class FishUpdateBody extends ConsumerStatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _FishUpdateBodyState createState() => _FishUpdateBodyState();
}

class _FishUpdateBodyState extends ConsumerState<FishUpdateBody> {
  late FishDTO fishDTO;
  late AquariumDTO aquariumDTO;

  late final _name = TextEditingController(text: "${fishDTO.name ?? ""}");
  late String fishClassEnum = fishDTO.fishClassEnum;
  late final _text = TextEditingController(text: "${fishDTO.text ?? ""}");
  late final _price = TextEditingController(text: "${fishDTO.price ?? ""}");
  late int quantity = fishDTO.quantity ?? 0;
  late bool? isMale = fishDTO.isMale;

  late String? photo = fishDTO.photo;
  late int aquariumId = fishDTO.aquariumId;

  @override
  void initState() {
    print("FishUpdateBody인잇스테이트");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("FishUpdateBody빌드됨");

    MainModel? model = ref.watch(mainProvider);
    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    ParamStore paramStore = ref.read(paramProvider);

    aquariumDTO = model.aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

    fishDTO = aquariumDTO.fishDTOList //
        .firstWhere((element) => element.id == paramStore.fishDetailId);

    return Form(
      key: widget._formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            SizedBox(height: 15),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    "${imageURL}${fishDTO.photo}",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, right: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 10))),
                    child: Text("사진 변경"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.blue.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text("주요 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  AquariumTextFormField("생물 이름", _name, validateNormal()),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("소속 어항", style: TextStyle(color: Colors.grey[600])),
                  ),
                  InkWell(
                    onTap: () {
                      print("소속어항클릭");
                    },
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Text("${aquariumDTO.title}", style: TextStyle(fontSize: 17)),
                        ),
                        Divider(color: Colors.black38, height: 1, thickness: 1),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 5),
                    alignment: Alignment(-1, 0),
                    child: Text("생물 종류", style: TextStyle(color: Colors.grey[600])),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (fishClassEnum != "FISH") {
                            fishClassEnum = "FISH";
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            fishClassEnum == "FISH" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("물고기",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: fishClassEnum == "FISH" ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if (fishClassEnum != "OTHER") {
                            fishClassEnum = "OTHER";
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            fishClassEnum == "OTHER" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("기타 생물",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: fishClassEnum == "OTHER" ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if (fishClassEnum != "PLANT") {
                            fishClassEnum = "PLANT";
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            fishClassEnum == "PLANT" ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("수초",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: fishClassEnum == "PLANT" ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.red.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text("상세 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  SizedBox(height: 10),
                  AquariumTextFormField("메모하기", _text, validateLong()),
                  AquariumTextFormField("가격", _price, validateNormal()),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("수량", style: TextStyle(color: Colors.grey[600])),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (quantity == null || quantity! < 1) {
                            quantity = 0;
                          } else {
                            quantity = quantity! - 1;
                          }
                          setState(() {});
                        },
                        child: Icon(Icons.remove_circle_outline, color: Colors.grey[600]),
                      ),
                      Text("  ${quantity}  ", style: TextStyle(fontSize: 17)),
                      InkWell(
                        onTap: () {
                          if (quantity == null) {
                            quantity = 1;
                          } else {
                            quantity = quantity! + 1;
                          }
                          setState(() {});
                        },
                        child: Icon(Icons.add_circle_outline, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(top: 15, bottom: 5),
                    child: Text("성별", style: TextStyle(color: Colors.grey[600])),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (isMale != null) {
                            isMale = null;
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            isMale == null ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("불명",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: isMale == null ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if (isMale != true) {
                            isMale = true;
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            isMale == true ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("수컷",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: isMale == true ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          if (isMale != false) {
                            isMale = false;
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            isMale == false ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("암컷",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: isMale == false ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text("생물 도감", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  SizedBox(height: 10),
                  fishDTO.book == null
                      ? Text("정보 없음")
                      : Row(
                          children: [
                            Text("${fishDTO.book!.normalName}"),
                            Text("${fishDTO.book!.biologyName}"),
                            Text("${fishDTO.book!.text}"),
                          ],
                        ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                print("fish업뎃 제출하기");
                if (widget._formKey.currentState!.validate()) {
                  print("validate통과");

                  FishRequestDTO fishRequestDTO = FishRequestDTO(fishClassEnum, _name.text, _text.text, quantity, isMale, photo, _price.text);

                  await ref.watch(mainProvider.notifier).notifyFishUpdate(aquariumId, fishDTO.id, fishRequestDTO);
                }
              },
              child: Text("제출하기"),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
