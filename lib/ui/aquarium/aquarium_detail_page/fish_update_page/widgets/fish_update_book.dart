import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdateBook extends ConsumerStatefulWidget {
  const FishUpdateBook({
    super.key,
  });

  @override
  _FishUpdateBookState createState() => _FishUpdateBookState();
}

class _FishUpdateBookState extends ConsumerState<FishUpdateBook> {
  void parentSetState() {
    print("parentSetState");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    FishDTO fishDTO = model.fishDTO;
    Book? book = model.book;

    List<Book>? bookList = ref.watch(bookProvider)?.bookList;
    if (bookList == null) {
      ref.read(bookProvider.notifier).notifyInit();
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("생물도감", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          ElevatedButton(
            onPressed: () async {
              ref.read(bookProvider.notifier).notifySearch("");
              showDialog(
                context: context,
                builder: (context) {
                  List<Book>? bookList = ref.watch(bookProvider)?.bookList;
                  if (bookList == null) {
                    ref.read(bookProvider.notifier).notifyInit();
                    return Center(child: CircularProgressIndicator());
                  }

                  return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      List<Book>? searchBookList = bookList;
                      String newSearchTerm = ref.watch(bookProvider)!.newSearchTerm ?? "대체함";
                      print("newSearchTerm : ${newSearchTerm}");
                      if (newSearchTerm == null || newSearchTerm.isEmpty) {
                        newSearchTerm = "임시";
                      }
                      searchBookList = searchBookList!
                          .where((element) =>
                              element.normalName.toLowerCase().contains(newSearchTerm!.toLowerCase()) ||
                              (element.biologyName != null && element.biologyName!.toLowerCase().contains(newSearchTerm.toLowerCase())))
                          .toList();

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
                        content: SingleChildScrollView(
                          child: book != null
                              ? Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        print("소속도감연동해제");
                                        ref.read(fishUpdateProvider.notifier).notifyBook(null);
                                        // parentSetState();
                                        // setState(() {});
                                        Navigator.pop(context);
                                      },
                                      child: Text("생물도감 연동 해제하기"),
                                    ),
                                  ],
                                )
                              : Container(
                                  height: (50 + (searchBookList!.length) * 75) > 240 ? 50 + (searchBookList!.length) * 75 : 240,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                          // isDense: true,
                                          contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                          // labelText: "검색어를 입력하세요.",
                                          hintText: "검색어를 입력하세요.",
                                          border: OutlineInputBorder(),
                                          // filled: true,
                                          // fillColor: Colors.grey,
                                          prefixIcon: Icon(Icons.search, size: 30),
                                        ),
                                        onChanged: (String? newSearchTerm) {
                                          if (newSearchTerm != null) {
                                            ref.read(bookProvider.notifier).notifySearch(newSearchTerm);
                                            setState(() {});
                                            print("newSearchTerm");
                                          }
                                        },
                                      ),
                                      for (Book e in searchBookList!)
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

                                                ref.read(fishUpdateProvider.notifier).notifyBook(e);

                                                parentSetState();
                                                // setState(() {});
                                                Navigator.pop(context);
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
                                                          style: TextStyle(
                                                              fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
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
                        ),
                      );
                    },
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
                        width: sizeGetScreenWidth(context),
                        fit: BoxFit.cover,
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
    );
  }
}
