import 'package:fishfront/data/model/book.dart';
import 'package:fishfront/ui/_common_widgets/my_bottom.dart';
import 'package:fishfront/ui/_common_widgets/my_appbar.dart';
import 'package:fishfront/ui/book/book_detail_page/book_detail_body.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage(this.book, {super.key});

  // final scaffoldKey = GlobalKey<ScaffoldState>();
  // final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: book.normalName, onTapFunction: () => {}),
      bottomNavigationBar: const MyBottom(),
      body: BookDetailBody(book),
    );
  }
}
