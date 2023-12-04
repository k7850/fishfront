import 'package:fishfront/ui/board/board_page/board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardPageSearch extends ConsumerWidget {
  const BoardPageSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // color: Colors.white,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      // margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        decoration: const InputDecoration(
          // isDense: true,
          contentPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
          // labelText: "",
          hintText: "검색어를 입력하세요.",
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Color.fromRGBO(210, 210, 210, 1),
          prefixIcon: Icon(Icons.search, size: 30),
        ),
        onChanged: (String? newSearchTerm) {
          if (newSearchTerm != null) {
            // ref.read(boardProvider.notifier).notifySearch(newSearchTerm);
          }
        },
      ),
    );
  }
}
