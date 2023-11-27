import 'package:flutter/material.dart';

class AquariumTextFormField extends StatelessWidget {
  AquariumTextFormField(this.textString, this._title, this.validate);

  String textString;
  TextEditingController _title;
  var validate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment(-1, 0),
          child: Text("${textString}", style: TextStyle(color: Colors.grey[600])),
        ),
        Container(
          height: 45,
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            ),
            controller: _title,
            validator: validate,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
