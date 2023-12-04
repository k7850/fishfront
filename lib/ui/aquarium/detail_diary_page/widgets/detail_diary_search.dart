import 'package:fishfront/ui/aquarium/detail_diary_page/detail_diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailDiarySearch extends ConsumerWidget {
  const DetailDiarySearch({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // color: Colors.blue.shade200,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  ref.read(detailDiaryProvider.notifier).notifySearch(newSearchTerm);
                }
              },
            ),
          ),
          const Spacer(),
          const Divider(color: Colors.grey, height: 1, thickness: 1),
        ],
      ),
    );
  }
}
