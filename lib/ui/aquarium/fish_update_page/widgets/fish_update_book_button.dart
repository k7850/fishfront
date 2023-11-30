import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdateBookButton extends ConsumerWidget {
  const FishUpdateBookButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    FishDTO fishDTO = model.fishDTO;
    Book? book = model.book;

    return ElevatedButton(
      onPressed: () async {
        ref.read(bookProvider.notifier).notifySearch("");
        showDialog(
          context: context,
          builder: (context) {
            List<Book>? bookList = ref.watch(bookProvider)?.bookList;
            if (bookList == null) {
              ref.read(bookProvider.notifier).notifyInit();
              return const Center(child: CircularProgressIndicator());
            }

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                List<Book>? searchBookList = bookList;
                String newSearchTerm = ref.watch(bookProvider)!.newSearchTerm ?? "대체함";
                print("newSearchTerm : $newSearchTerm");
                if (newSearchTerm.isEmpty) {
                  newSearchTerm = "임시";
                }
                searchBookList = searchBookList
                    .where((element) =>
                        element.normalName.toLowerCase().contains(newSearchTerm.toLowerCase()) ||
                        (element.biologyName != null && element.biologyName!.toLowerCase().contains(newSearchTerm.toLowerCase())))
                    .toList();

                return AlertDialog(
                  title: RichText(
                    text: TextSpan(
                      text: "${fishDTO.name}",
                      style: const TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
                      children: const [
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
                                child: const Text("생물도감 연동 해제하기"),
                              ),
                            ],
                          )
                        : SizedBox(
                            height: (50 + (searchBookList.length) * 75) > 240 ? 50 + (searchBookList.length) * 75 : 240,
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
                                for (Book e in searchBookList)
                                  Column(
                                    children: [
                                      const Divider(color: Colors.grey, height: 1, thickness: 1),
                                      const SizedBox(height: sizeS5),
                                      InkWell(
                                        onTap: () async {
                                          if (e.id == book?.id) {
                                            print("현재소속도감임");
                                            return;
                                          }
                                          print("${e.normalName}");

                                          ref.read(fishUpdateProvider.notifier).notifyBook(e);

                                          // parentSetState();
                                          // setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                "$imageURL${e.photo}",
                                                width: sizeGetScreenWidth(context) * 0.2,
                                                height: sizeGetScreenWidth(context) * 0.15,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(width: sizeM10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(e.normalName, style: const TextStyle(fontSize: 18, fontFamily: "Giants")),
                                                e.id == book?.id
                                                    ? Text("현재 소속 생물도감",
                                                        style: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: "Giants"))
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            const Spacer(),
                                            e.id == book?.id
                                                ? const Text("X ",
                                                    style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold, fontFamily: ""))
                                                : const Text("> ", style: TextStyle(fontSize: 20, color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: sizeS5),
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
      child: const Text("연동하기"),
    );
  }
}
