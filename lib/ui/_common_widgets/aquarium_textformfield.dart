import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AquariumTextFormField extends ConsumerWidget {
  AquariumTextFormField(this.textString, this.textEditingController, this.validate, this.notifyFunction, {super.key, this.isLong = false});

  bool isLong;
  String textString;
  TextEditingController textEditingController;
  var validate;
  Function(String) notifyFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Align(
          alignment: const Alignment(-1, 0),
          child: Text(textString, style: TextStyle(color: Colors.grey[600])),
        ),
        Container(
          margin: isLong ? const EdgeInsets.only(top: 5) : const EdgeInsets.only(),
          height: isLong ? 100 : 45,
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) notifyFunction(textEditingController.text);
            },
            child: TextFormField(
              maxLines: isLong ? 5 : 1,
              decoration: isLong
                  ? const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                    )
                  : const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    ),
              controller: textEditingController,
              validator: validate,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
