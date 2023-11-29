import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/schedule_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/data/provider/param_provider.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_fishclassenum.dart';
import 'package:fishfront/ui/book/book_page/widgets/book_page_isfreshwater.dart';
import 'package:fishfront/ui/main/aquarium_detail_page/aquarium_detail_page.dart';
import 'package:fishfront/ui/main/main_page/widgets/aquarium_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BookBody extends ConsumerStatefulWidget {
  BookBody();

  @override
  _BookBodyState createState() => _BookBodyState();
}

class _BookBodyState extends ConsumerState<BookBody> {
  @override
  Widget build(BuildContext context) {
    print("_BookBodyState 빌드");

    List<Book> bookList = ref.watch(bookProvider)!.bookList;

    bool? isFreshWater = ref.watch(bookProvider)!.isFreshWater;
    String fishClassEnum = ref.watch(bookProvider)!.fishClassEnum;

    List<Book> selectBookList = bookList;

    if (fishClassEnum.isNotEmpty) {
      selectBookList = selectBookList.where((element) => element.fishClassEnum == fishClassEnum).toList();
    }

    if (isFreshWater != null) {
      selectBookList = selectBookList.where((element) => element.isFreshWater == isFreshWater).toList();
    }

    return Column(
      children: [
        const BookPageIsfreshwater(),
        const BookPageFishclassenum(),
        Text("검색"),
        Divider(color: Colors.grey, height: 1, thickness: 1),
        SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
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
                              constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.7),
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
                              constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.65),
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
        ),
      ],
    );
  }
}
