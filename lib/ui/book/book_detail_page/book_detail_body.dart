import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/_common_widgets/select_aquarium.dart';
import 'package:flutter/material.dart';

import '../../_common_widgets/difficulty_string.dart';

class BookDetailBody extends StatelessWidget {
  final Book book;

  const BookDetailBody(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    print("_BookDetailBody 빌드");

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          const SizedBox(height: 15),
          Hero(
            tag: "bookphotohero${book.id}",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "$imageURL${book.photo}",
                width: sizeGetScreenWidth(context),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(book.normalName, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 5),
          Text("${book.biologyName}", style: TextStyle(color: Colors.grey[600])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: DifficultyString(difficulty: book.difficulty ?? 1),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SelectAquarium(
                        mainText: book.normalName,
                        book: book,
                      );
                    },
                  );
                },
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size.zero),
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 5, horizontal: 10))),
                child: const Text("어항에 추가"),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text("${book.text}", style: TextStyle(fontSize: 15, color: Colors.grey[600])),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
