import 'package:flutter/material.dart';

List<TextSpan> getMatchWordSpans(String text, String matchWord, TextStyle style) {
  // 예시
  // RichText(
  //   maxLines: 1,
  //   overflow: TextOverflow.ellipsis,
  //   text: TextSpan(
  //     style: const TextStyle(fontSize: 15, color: Colors.black, fontFamily: "Giants"),
  //     children: getSpans(boardMainDTO.title, keyword, const TextStyle(color: Colors.red)),
  //   ),
  // ),

  List<TextSpan> spans = [];
  int spanBoundary = 0;

  if (matchWord.isEmpty) {
    print("matchWord가 비었음.");
    matchWord = "matchWord.isEmpty 대체";
  }
  do {
    // 전체 String 에서 키워드 검색
    final startIndex = text.indexOf(matchWord, spanBoundary);

    // 전체 String 에서 해당 키워드가 더 이상 없을때 마지막 KeyWord부터 끝까지의 TextSpan 추가
    if (startIndex == -1) {
      spans.add(TextSpan(text: text.substring(spanBoundary)));
      return spans;
    }

    // 전체 String 사이에서 발견한 키워드들 사이의 text에 대한 textSpan 추가
    if (startIndex > spanBoundary) {
      // print(text.substring(spanBoundary, startIndex));
      spans.add(TextSpan(text: text.substring(spanBoundary, startIndex)));
    }

    // 검색하고자 했던 키워드에 대한 textSpan 추가
    final endIndex = startIndex + matchWord.length;
    final spanText = text.substring(startIndex, endIndex);
    spans.add(TextSpan(text: spanText, style: style));

    // mark the boundary to start the next search from
    spanBoundary = endIndex;

    // continue until there are no more matches
  } while (spanBoundary < text.length); //String 전체 검사

  return spans;
}
