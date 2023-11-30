import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_book.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_important.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_photo.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_unimportant.dart';
import 'package:fishfront/ui/aquarium/fish_update_page/widgets/fish_update_button.dart';
import 'package:fishfront/ui/book/book_page/book_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FishUpdateBody extends ConsumerStatefulWidget {
  const FishUpdateBody({super.key});

  @override
  _FishUpdateBodyState createState() => _FishUpdateBodyState();
}

class _FishUpdateBodyState extends ConsumerState<FishUpdateBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("FishUpdateBody빌드됨");

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
            const FishUpdatePhoto(),
            const SizedBox(height: 15),
            const FishUpdateImportant(),
            const SizedBox(height: 15),
            const FishUpdateUnimportant(),
            const SizedBox(height: 15),
            const FishUpdateBook(),
            const SizedBox(height: 10),
            FishUpdateButton(_formKey),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
