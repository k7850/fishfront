import 'package:fishfront/ui/_common_widgets/my_checkbox.dart';
import 'package:fishfront/ui/_common_widgets/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../_core/utils/validator_util.dart';
import '../../../_common_widgets/aquarium_textformfield.dart';
import '../fish_update_view_model.dart';

class FishUpdateUnimportant extends ConsumerStatefulWidget {
  const FishUpdateUnimportant({
    super.key,
  });

  @override
  _FishUpdateUnimportantState createState() => _FishUpdateUnimportantState();
}

class _FishUpdateUnimportantState extends ConsumerState<FishUpdateUnimportant> {
  @override
  Widget build(BuildContext context) {
    FishUpdateModel model = ref.watch(fishUpdateProvider)!;

    TextEditingController _text = model.text;
    TextEditingController _price = model.price;

    int quantity = model.quantity;
    bool? isMale = model.isMale;

    return Container(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.red.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("추가 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          const SizedBox(height: 10),
          AquariumTextFormField(
              isLong: true, "메모하기", _text, validateLong(), (String value) => ref.read(fishUpdateProvider.notifier).notifyText(value)),
          AquariumTextFormField("가격", _price, validateOkEmpty(), (String value) => ref.read(fishUpdateProvider.notifier).notifyPrice(value)),
          const SubTitle(subTitle: "수량", top: 0),
          Row(
            children: [
              InkWell(
                onTap: () {
                  quantity < 1
                      ? ref.read(fishUpdateProvider.notifier).notifyQuantity(0)
                      : ref.read(fishUpdateProvider.notifier).notifyQuantity(quantity - 1);
                  // setState(() {});
                },
                child: Icon(Icons.remove_circle_outline, color: Colors.grey[600]),
              ),
              Text("  $quantity  ", style: const TextStyle(fontSize: 17)),
              InkWell(
                onTap: () {
                  ref.read(fishUpdateProvider.notifier).notifyQuantity(quantity + 1);
                  // setState(() {});
                },
                child: Icon(Icons.add_circle_outline, color: Colors.grey[600]),
              ),
            ],
          ),
          const SubTitle(subTitle: "성별"),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (isMale != null) {
                    ref.read(fishUpdateProvider.notifier).notifyIsMale(null);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "불명", isChecked: isMale == null),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (isMale != true) {
                    ref.read(fishUpdateProvider.notifier).notifyIsMale(true);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "수컷", isChecked: isMale == true),
              ),
              const SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (isMale != false) {
                    ref.read(fishUpdateProvider.notifier).notifyIsMale(false);
                    // setState(() {});
                  }
                },
                child: MyCheckbox(str: "암컷", isChecked: isMale == false),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
