import 'dart:io';

import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/_core/utils/validator_util.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/dto/fish_request_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/auth/login_page/widgets/custom_login_text_form_field.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:fishfront/ui/main/main_page/main_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
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

  late Book? book = fishDTO.book;

  File? imageFile;

  MainModel? model;

  @override
  void initState() {
    print("FishUpdateBody인잇스테이트");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("FishUpdateBody didChangeDependencies");

    model = ref.watch(mainProvider);

    ParamStore paramStore = ref.read(paramProvider);

    // aquariumDTO = model!.aquariumDTOList //
    //     .firstWhere((element) => element.id == paramStore.aquariumDetailId);
    //
    // fishDTO = aquariumDTO.fishDTOList //
    //     .firstWhere((element) => element.id == paramStore.fishDetailId);

    fishDTO = model!.aquariumDTOList
        .expand((element) => element.fishDTOList) //
        .firstWhere((element) => element.id == paramStore.fishDetailId);

    aquariumDTO = model!.aquariumDTOList //
        .firstWhere((element) => element.id == fishDTO.aquariumId);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("FishUpdateBody빌드됨");

    if (model == null) {
      ref.read(mainProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    List<Book>? bookList = ref.watch(bookProvider)?.bookList;
    if (bookList == null) {
      ref.read(bookProvider.notifier).notifyInit();
    }

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
                  child: imageFile != null
                      ? Image.file(imageFile!)
                      : Image.network(
                          fishDTO.photo != null && fishDTO.photo!.isNotEmpty ? "${imageURL}${fishDTO.photo}" : "${imageURL}${book?.photo}",
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/fish.png");
                          },
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, right: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      imageFile = File(image.path);
                      setState(() {});
                    },
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
                  Text("필수 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  AquariumTextFormField("생물 이름", _name, validateNormal()),
                  Container(
                    alignment: Alignment(-1, 0),
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text("소속 어항", style: TextStyle(color: Colors.grey[600])),
                  ),
                  InkWell(
                    onTap: () {
                      print("소속어항");
                      ScaffoldMessenger.of(context).clearSnackBars();

                      List<AquariumDTO> aquariumDTOList = ref.watch(mainProvider)!.aquariumDTOList;

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: RichText(
                              text: TextSpan(
                                text: "${fishDTO.name}",
                                style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
                                children: [
                                  TextSpan(text: " 소속시킬 어항", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "")),
                                ],
                              ),
                            ),
                            content: Container(
                              height: 5 + aquariumDTOList.length * 75,
                              child: Column(
                                children: [
                                  for (AquariumDTO aquariumDTO in aquariumDTOList)
                                    Column(
                                      children: [
                                        Divider(color: Colors.grey, height: 1, thickness: 1),
                                        SizedBox(height: sizeS5),
                                        InkWell(
                                          onTap: () async {
                                            if (aquariumDTO.id == fishDTO.aquariumId) {
                                              print("현재소속어항임");
                                              return;
                                            }
                                            print("${aquariumDTO.title}");
                                            this.aquariumDTO = aquariumDTO;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                  "${imageURL}${aquariumDTO.photo}",
                                                  width: sizeGetScreenWidth(context) * 0.2,
                                                  height: sizeGetScreenWidth(context) * 0.15,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(width: sizeM10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${aquariumDTO.title}", style: TextStyle(fontSize: 18, fontFamily: "Giants")),
                                                  aquariumDTO.id == fishDTO.aquariumId
                                                      ? Text("현재 소속 어항",
                                                          style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
                                                      : SizedBox(),
                                                ],
                                              ),
                                              Spacer(),
                                              aquariumDTO.id == fishDTO.aquariumId
                                                  ? Text("X ",
                                                      style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
                                                  : Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: sizeS5),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
                  Text("추가 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
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
                  Text("생물도감", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: RichText(
                              text: TextSpan(
                                text: "${fishDTO.name}",
                                style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
                                children: [
                                  TextSpan(text: " 연동할 생물도감", style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "")),
                                ],
                              ),
                            ),
                            content: Container(
                              height: 5 + (bookList!.length + 1) * 75,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Divider(color: Colors.grey, height: 1, thickness: 1),
                                      SizedBox(height: sizeS5),
                                      InkWell(
                                        onTap: () async {
                                          if (book == null) {
                                            print("현재소속도감없음");
                                            return;
                                          }
                                          print("소속도감연동해제");
                                          book = null;
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            Container(
                                              height: sizeGetScreenWidth(context) * 0.15,
                                              child: Center(child: Text("생물도감 연동 해제", style: TextStyle(fontSize: 18, fontFamily: "Giants"))),
                                            ),
                                            Spacer(),
                                            book == null
                                                ? Text("X ",
                                                    style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
                                                : Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: sizeS5),
                                    ],
                                  ),
                                  for (Book e in bookList!)
                                    Column(
                                      children: [
                                        Divider(color: Colors.grey, height: 1, thickness: 1),
                                        SizedBox(height: sizeS5),
                                        InkWell(
                                          onTap: () async {
                                            if (e.id == book?.id) {
                                              print("현재소속도감임");
                                              return;
                                            }
                                            print("${e.normalName}");
                                            book = e;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network(
                                                  "${imageURL}${e.photo}",
                                                  width: sizeGetScreenWidth(context) * 0.2,
                                                  height: sizeGetScreenWidth(context) * 0.15,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(width: sizeM10),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("${e.normalName}", style: TextStyle(fontSize: 18, fontFamily: "Giants")),
                                                  e.id == book?.id
                                                      ? Text("현재 소속 생물도감",
                                                          style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
                                                      : SizedBox(),
                                                ],
                                              ),
                                              Spacer(),
                                              e.id == book?.id
                                                  ? Text("X ",
                                                      style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
                                                  : Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: sizeS5),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text("연동하기"),
                  ),
                  book == null
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "${imageURL}${book!.photo}",
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset("assets/fish.png");
                                },
                              ),
                            ),
                            SizedBox(height: 15),
                            Text("${book!.normalName}", style: TextStyle(fontSize: 17)),
                            Text("${book!.biologyName}", style: TextStyle(color: Colors.grey[600])),
                            SizedBox(height: 5),
                            RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: "사육 난이도 : ",
                                style: TextStyle(color: Colors.black, fontFamily: "Giants"),
                                children: [
                                  TextSpan(
                                    text:
                                        "${book!.difficulty == 1 ? "아주 쉬움" : book!.difficulty == 2 ? "쉬움" : book!.difficulty == 3 ? "보통" : book!.difficulty == 4 ? "어려움" : "아주 어려움"}",
                                    style: TextStyle(
                                        fontFamily: "Giants",
                                        fontSize: 15,
                                        color: book!.difficulty == 1
                                            ? Colors.green
                                            : book!.difficulty == 2
                                                ? Colors.blue
                                                : book!.difficulty == 3
                                                    ? Colors.black
                                                    : book!.difficulty == 4
                                                        ? Colors.orange
                                                        : Colors.red[800]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("${book!.text}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
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

                  FishRequestDTO fishRequestDTO =
                      FishRequestDTO(fishClassEnum, _name.text, _text.text, quantity, isMale, photo, _price.text, book?.id);

                  await ref.watch(mainProvider.notifier).notifyFishUpdate(aquariumDTO.id, fishDTO.id, fishRequestDTO, imageFile);
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

  // Future getImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (image == null) return;
  //
  //   imageFile = File(image.path);
  //
  //   setState(() {});
  // }
}
