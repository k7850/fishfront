import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../book/book_page/book_view_model.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function onTapFunction;

  const MyAppbar({required this.title, required this.onTapFunction, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(title, style: const TextStyle(fontSize: 25, color: Colors.black)),
      actions: [
        InkWell(
          onTap: () => onTapFunction(),
          child: const Icon(Icons.menu, size: 30, color: Colors.black),
        ),
        const SizedBox(width: 20),
      ],
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
