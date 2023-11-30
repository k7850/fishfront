import 'package:fishfront/data/provider/param_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../_core/constants/http.dart';
import '../../../../_core/constants/size.dart';
import '../../../../data/model/book.dart';

class BookPageItem extends ConsumerWidget {
  const BookPageItem({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20),
      child: InkWell(
        onTap: () {
          print("book.id : ${book.id}");
          ParamStore paramStore = ref.read(paramProvider);
          paramStore.addBookDetailId(book.id);
          print("paramStore.addBookDetailId : ${paramStore.addBookDetailId}");
          // Navigator.push(context, MaterialPageRoute(builder: (_) => BookDetailPage()));
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "$imageURL${book.photo}",
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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.7),
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Giants"),
                      text: "${book.normalName} ",
                      children: [
                        TextSpan(
                          text: "${book.biologyName}",
                          style: const TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "JamsilRegular"),
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
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
