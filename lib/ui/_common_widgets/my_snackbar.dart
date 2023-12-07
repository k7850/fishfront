import 'package:fishfront/main.dart';
import 'package:flutter/material.dart';

import '../../_core/constants/size.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackbar(int durationMS, Widget snackbarRow) {
  return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: snackbarRow,
      duration: Duration(milliseconds: durationMS),
      behavior: SnackBarBehavior.floating,
      width: sizeGetScreenWidth(navigatorKey.currentContext!) * 0.8,
    ),
  );
}

Row mySnackbarRow1(String text1, String text2, String text3, String text4) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        alignment: Alignment.center,
        width: sizeGetScreenWidth(navigatorKey.currentContext!) * 0.7,
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: "${text1}",
            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
            children: [
              TextSpan(
                text: "${text2}",
                style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: ""),
              ),
              TextSpan(
                text: "${text3}",
                style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
              ),
              TextSpan(
                text: "${text4}",
                style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: ""),
              ),
            ],
          ),
        ),
      )
    ],
  );
}

Row mySnackbarRowAlert(String text1, String text2, BuildContext context, Function func) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        constraints: BoxConstraints(maxWidth: sizeGetScreenWidth(context) * 0.5),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            text: "${text1}",
            style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: "Giants"),
            children: [
              TextSpan(text: " ${text2}?", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "")),
            ],
          ),
        ),
      ),
      const SizedBox(width: sizeM10),
      InkWell(
        child: const Icon(Icons.check, color: Colors.red),
        onTap: () async {
          // print("스낵바-삭제누름");
          ScaffoldMessenger.of(context).clearSnackBars();
          await func();
          // await ref.read(boardDetailProvider.notifier).notifyCommentDelete(commentDTOList[index].id);
        },
      ),
      const SizedBox(width: sizeM10),
      InkWell(
        child: const Icon(Icons.clear, color: Colors.white),
        onTap: () {
          ScaffoldMessenger.of(context).clearSnackBars();
        },
      ),
    ],
  );
}
