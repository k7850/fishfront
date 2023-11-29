import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/auth/login_page/widgets/custom_login_text_form_field.dart';
import 'package:fishfront/ui/aquarium/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../_common_widgets/aquarium_textformfield.dart';

class DetailOtherBody extends ConsumerStatefulWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  _DetailOtherBodyState createState() => _DetailOtherBodyState();
}

class _DetailOtherBodyState extends ConsumerState<DetailOtherBody> {
  late AquariumDTO aquariumDTO;

  late final _title = TextEditingController(text: "${aquariumDTO.title ?? ""}");
  late final _intro = TextEditingController(text: "${aquariumDTO.intro ?? ""}");
  late final _size1 = TextEditingController(text: "${aquariumDTO.size?.split("/")[0] ?? "0"}");
  late final _size2 = TextEditingController(text: "${aquariumDTO.size?.split("/")[1] ?? "0"}");
  late final _size3 = TextEditingController(text: "${aquariumDTO.size?.split("/")[2] ?? "0"}");
  late final _s1 = TextEditingController(text: "${aquariumDTO.s1?.split(":")[1] ?? ""}");
  late final _s2 = TextEditingController(text: "${aquariumDTO.s2?.split(":")[1] ?? ""}");
  late final _s3 = TextEditingController(text: "${aquariumDTO.s3?.split(":")[1] ?? ""}");
  late final _s4 = TextEditingController(text: "${aquariumDTO.s4?.split(":")[1] ?? ""}");
  late final _s5 = TextEditingController(text: "${aquariumDTO.s5?.split(":")[1] ?? ""}");

  @override
  void initState() {
    print("DetailOtherBody인잇스테이트");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("DetailOtherBody빌드됨");

    MainModel? model = ref.watch(mainProvider);
    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    ParamStore paramStore = ref.read(paramProvider);

    aquariumDTO = model.aquariumDTOList //
        .firstWhere((element) => element.id == paramStore.aquariumDetailId);

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
                    "${imageURL}${aquariumDTO.photo}",
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
                  Text("어항 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  // AquariumTextFormField("어항 이름", _title, validateNormal()),
                  // AquariumTextFormField("메모하기", _intro, validateLong()),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("어항 종류", style: TextStyle(color: Colors.grey[600])),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (aquariumDTO.isFreshWater == false) {
                            aquariumDTO.isFreshWater = true;
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            aquariumDTO.isFreshWater! ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("담수 어항",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: aquariumDTO.isFreshWater! ? Colors.black : Colors.grey[600],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 30),
                      InkWell(
                        onTap: () {
                          if (aquariumDTO.isFreshWater == true) {
                            aquariumDTO.isFreshWater = false;
                            setState(() {});
                          }
                        },
                        child: Row(
                          children: [
                            !aquariumDTO.isFreshWater! ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                            SizedBox(width: 5),
                            Container(
                              child: Text("해수 어항",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: !aquariumDTO.isFreshWater! ? Colors.black : Colors.grey[600],
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
                  Text("어항 사이즈", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("길이", style: TextStyle(color: Colors.grey[600])),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(),
                              controller: _size1,
                              validator: (value) {
                                return validateAquariumSize()(value);
                              },
                              onTapOutside: (event) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text("폭", style: TextStyle(color: Colors.grey[600])),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(),
                              controller: _size2,
                              validator: (value) {
                                return validateAquariumSize()(value);
                              },
                              onTapOutside: (event) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          Text("높이", style: TextStyle(color: Colors.grey[600])),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(),
                              controller: _size3,
                              validator: (value) {
                                return validateAquariumSize()(value);
                              },
                              onTapOutside: (event) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        int.tryParse(_size1.text) != null && int.tryParse(_size2.text) != null && int.tryParse(_size3.text) != null
                            ? "부피 : ${int.parse(_size1.text) * int.parse(_size2.text) * int.parse(_size3.text) / 1000} 리터"
                            : "부피 오류",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text("어항 장비", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  AquariumTextFormField("${aquariumDTO.s1?.split(":")[0] ?? ""}", _s1, validateOkEmpty(), (value) => print("${value}")),
                  AquariumTextFormField("${aquariumDTO.s2?.split(":")[0] ?? ""}", _s2, validateOkEmpty(), (value) => print("${value}")),
                  AquariumTextFormField("${aquariumDTO.s3?.split(":")[0] ?? ""}", _s3, validateOkEmpty(), (value) => print("${value}")),
                  AquariumTextFormField("${aquariumDTO.s4?.split(":")[0] ?? ""}", _s4, validateOkEmpty(), (value) => print("${value}")),
                  AquariumTextFormField("${aquariumDTO.s5?.split(":")[0] ?? ""}", _s5, validateOkEmpty(), (value) => print("${value}")),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                print("aaaaa");
                if (widget._formKey.currentState!.validate()) {
                  print("a3sd");
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
