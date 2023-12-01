import 'package:fishfront/ui/aquarium/fish_create_page/fish_create_view_model.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/widgets/fish_create_book.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/widgets/fish_create_button.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/widgets/fish_create_important.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/widgets/fish_create_photo.dart';
import 'package:fishfront/ui/aquarium/fish_create_page/widgets/fish_create_unimportant.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiaryCreateBody extends ConsumerStatefulWidget {
  const DiaryCreateBody({super.key});

  @override
  _DiaryCreateBodyState createState() => _DiaryCreateBodyState();
}

class _DiaryCreateBodyState extends ConsumerState<DiaryCreateBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("FishCreateBody빌드됨");

    FishCreateModel? model = ref.watch(fishCreateProvider);
    if (model == null) {
      ref.read(fishCreateProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    BookModel? bookModel = ref.watch(bookProvider);
    if (bookModel == null) {
      ref.read(bookProvider.notifier).notifyInit();
      return const Center(child: CircularProgressIndicator());
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            const FishCreatePhoto(),
            const SizedBox(height: 15),
            const FishCreateImportant(),
            const SizedBox(height: 15),
            const FishCreateUnimportant(),
            const SizedBox(height: 15),
            const FishCreateBook(),
            const SizedBox(height: 10),
            FishCreateButton(_formKey),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
