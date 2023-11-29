import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../_core/constants/enum.dart';
import '../../../../../_core/constants/http.dart';
import '../../../../../_core/constants/size.dart';
import '../../../../../_core/utils/validator_util.dart';
import '../../../../../data/dto/aquarium_dto.dart';
import '../../../../../data/dto/fish_dto.dart';
import '../../../../_common_widgets/aquarium_textformfield.dart';
import '../../../main_page/main_view_model.dart';
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
      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
      decoration: BoxDecoration(color: Colors.red.withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text("추가 정보", style: TextStyle(fontSize: 20, color: Colors.grey[600])),
          SizedBox(height: 10),
          AquariumTextFormField("메모하기", _text, validateLong(), (String value) => ref.read(fishUpdateProvider.notifier).notifyText(value)),
          AquariumTextFormField("가격", _price, validateOkEmpty(), (String value) => ref.read(fishUpdateProvider.notifier).notifyPrice(value)),
          Container(
            alignment: Alignment(-1, 0),
            padding: EdgeInsets.only(bottom: 5),
            child: Text("수량", style: TextStyle(color: Colors.grey[600])),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (quantity == null || quantity! < 1) {
                    ref.read(fishUpdateProvider.notifier).notifyQuantity(0);
                  } else {
                    ref.read(fishUpdateProvider.notifier).notifyQuantity(quantity - 1);
                  }
                  // setState(() {});
                },
                child: Icon(Icons.remove_circle_outline, color: Colors.grey[600]),
              ),
              Text("  ${quantity}  ", style: TextStyle(fontSize: 17)),
              InkWell(
                onTap: () {
                  if (quantity == null) {
                    ref.read(fishUpdateProvider.notifier).notifyQuantity(1);
                  } else {
                    ref.read(fishUpdateProvider.notifier).notifyQuantity(quantity + 1);
                  }
                  // setState(() {});
                },
                child: Icon(Icons.add_circle_outline, color: Colors.grey[600]),
              ),
            ],
          ),
          Container(
            alignment: Alignment(-1, 0),
            padding: EdgeInsets.only(top: 15, bottom: 5),
            child: Text("성별", style: TextStyle(color: Colors.grey[600])),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  if (isMale != null) {
                    ref.read(fishUpdateProvider.notifier).notifyIsMale(null);
                    // setState(() {});
                  }
                },
                child: Row(
                  children: [
                    isMale == null ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                    SizedBox(width: 5),
                    Container(
                      child: Text("불명",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: isMale == null ? Colors.black : Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (isMale != true) {
                    ref.read(fishUpdateProvider.notifier).notifyIsMale(true);
                    // setState(() {});
                  }
                },
                child: Row(
                  children: [
                    isMale == true ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                    SizedBox(width: 5),
                    Container(
                      child: Text("수컷",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: isMale == true ? Colors.black : Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  if (isMale != false) {
                    ref.read(fishUpdateProvider.notifier).notifyIsMale(false);
                    // setState(() {});
                  }
                },
                child: Row(
                  children: [
                    isMale == false ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank, color: Colors.grey[600]),
                    SizedBox(width: 5),
                    Container(
                      child: Text("암컷",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            color: isMale == false ? Colors.black : Colors.grey[600],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
