import 'package:fishfront/ui/aquarium/fish_update_page/fish_update_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AquariumTextFormField extends ConsumerWidget {
  AquariumTextFormField(this.textString, this.textEditingController, this.validate, this.notifyFunction);

  String textString;
  TextEditingController textEditingController;
  var validate;
  Function(String) notifyFunction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Align(
          alignment: Alignment(-1, 0),
          child: Text("${textString}", style: TextStyle(color: Colors.grey[600])),
        ),
        Container(
          height: 45,
          child: Focus(
            onFocusChange: (hasFocus) {
              if (!hasFocus) notifyFunction(textEditingController.text);
            },
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              ),
              controller: textEditingController,
              validator: validate,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
