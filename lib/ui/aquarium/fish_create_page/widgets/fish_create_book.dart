import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/_common_widgets/difficulty_string.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/fish_create_view_model.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/widgets/fish_create_book_button.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishCreateBook extends ConsumerStatefulWidget {
  const FishCreateBook({
    super.key,
  });

  @override
  _FishCreateBookState createState() => _FishCreateBookState();
}

class _FishCreateBookState extends ConsumerState<FishCreateBook> {
  // void parentSetState() {
  //   print("parentSetState");
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    FishCreateModel model = ref.watch(fishCreateProvider)!;

    Book? book = model.book;

    List<Book>? bookList = ref.watch(bookProvider)?.bookList;
    if (bookList == null) {
      ref.read(bookProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.green.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("생물도감", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          const FishCreateBookButton(),
          book == null
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "$imageURL${book.photo}",
                        width: sizeGetScreenWidth(context),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/fish.png");
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(book.normalName, style: const TextStyle(fontSize: 17)),
                    Text("${book.biologyName}", style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 5),
                    DifficultyString(difficulty: book.difficulty ?? 1),
                    const SizedBox(height: 10),
                    Text("${book.text}", style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                  ],
                ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
