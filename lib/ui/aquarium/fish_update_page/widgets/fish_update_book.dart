import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/_common_widgets/difficulty_string.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_view_model.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_book_button.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
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
  // void parentSetState() {
  //   print("parentSetState");
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

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
          const FishUpdateBookButton(),
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
