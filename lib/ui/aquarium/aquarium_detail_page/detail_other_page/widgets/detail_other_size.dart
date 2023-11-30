import 'dart:io';

import 'package:fishfront/_core/constants/http.dart';
import 'package:fishfront/_core/constants/size.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/ui/_common_widgets/aquarium_textformfield.dart';
import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:fishfront/ui/aquarium/aquarium_detail_page/detail_other_page/detail_other_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fishfront/_core/utils/validator_util.dart';

class DetailOtherSize extends ConsumerWidget {
  const DetailOtherSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DetailOtherModel model = ref.watch(detailOtherProvider)!;

    TextEditingController _size1 = model.size1;
    TextEditingController _size2 = model.size2;
    TextEditingController _size3 = model.size3;

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.red.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("어항 사이즈", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  Text("길이", style: TextStyle(color: Colors.grey[600])),
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(),
                      controller: _size1,
                      validator: (value) {
                        return validateAquariumSize()(value);
                      },
                      onChanged: (String size) {
                        ref.read(detailOtherProvider.notifier).notifySize1(size);
                        // setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text("폭", style: TextStyle(color: Colors.grey[600])),
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(),
                      controller: _size2,
                      validator: (value) {
                        return validateAquariumSize()(value);
                      },
                      onChanged: (String size) {
                        ref.read(detailOtherProvider.notifier).notifySize2(size);
                        // setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text("높이", style: TextStyle(color: Colors.grey[600])),
                  SizedBox(
                    width: 50,
                    height: 30,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(),
                      controller: _size3,
                      validator: (value) {
                        return validateAquariumSize()(value);
                      },
                      onChanged: (String size) {
                        ref.read(detailOtherProvider.notifier).notifySize3(size);
                        // setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                int.tryParse(_size1.text) != null && int.tryParse(_size2.text) != null && int.tryParse(_size3.text) != null
                    ? "부피 : ${int.parse(_size1.text) * int.parse(_size2.text) * int.parse(_size3.text) / 1000} 리터"
                    : "부피 오류",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
