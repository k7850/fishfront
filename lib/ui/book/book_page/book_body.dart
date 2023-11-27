import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/main/main_page/widgets/aquarium_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookBody extends ConsumerStatefulWidget {
  List<Book> bookList;
  BookBody(this.bookList);

  @override
  _BookBodyState createState() => _BookBodyState();
}

class _BookBodyState extends ConsumerState<BookBody> {
  bool? isFreshWater;
  String fishClassEnum = "";

  @override
  Widget build(BuildContext context) {
    List<Book> selectBookList = widget.bookList;

    if (fishClassEnum.isNotEmpty) {
      selectBookList = selectBookList.where((element) => element.fishClassEnum == fishClassEnum).toList();
    }

    return Column(
      children: [
        Text("검색"),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (isFreshWater == true) {
                  isFreshWater = null;
                } else {
                  isFreshWater = true;
                }
                setState(() {});
              },
              child: Row(
                children: [
                  isFreshWater == true ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Container(
                    child: Text("담수 어항",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: isFreshWater == true ? Colors.black : Colors.grey[600],
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            InkWell(
              onTap: () {
                if (isFreshWater == false) {
                  isFreshWater = null;
                } else {
                  isFreshWater = false;
                }
                setState(() {});
              },
              child: Row(
                children: [
                  isFreshWater == false ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Container(
                    child: Text("해수 어항",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: isFreshWater == false ? Colors.black : Colors.grey[600],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            InkWell(
              onTap: () {
                if (fishClassEnum != "FISH") {
                  fishClassEnum = "FISH";
                } else {
                  fishClassEnum = "";
                }
                setState(() {});
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
                } else {
                  fishClassEnum = "";
                }
                setState(() {});
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
                } else {
                  fishClassEnum = "";
                }
                setState(() {});
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
        Divider(color: Colors.grey, height: 1, thickness: 1),
        Expanded(
          child: ListView(
            children: [
              for (Book book in selectBookList)
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "${imageURL}${book.photo}",
                          width: sizeGetScreenWidth(context) * 0.2,
                          height: sizeGetScreenWidth(context) * 0.2,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/fish.png",
                              width: sizeGetScreenWidth(context) * 0.2,
                              height: sizeGetScreenWidth(context) * 0.2,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Giants"),
                                text: "${book.normalName} ",
                                children: [
                                  TextSpan(
                                    text: "${book.biologyName}",
                                    style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "JamsilRegular"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.6),
                            child: Text(
                              "${book.text}",
                              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
