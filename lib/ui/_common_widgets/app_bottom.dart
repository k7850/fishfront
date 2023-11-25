import 'package:fishfront/data/provider/param_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBottom extends ConsumerStatefulWidget {
  const AppBottom({
    super.key,
  });

  @override
  _AppBottomState createState() => _AppBottomState();
}

class _AppBottomState extends ConsumerState<AppBottom> {
  late ParamStore ps;

  @override
  Widget build(BuildContext context) {
    ps = ref.read(paramProvider);

    return Container(
      height: 55,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey, width: 1))),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // 아이템 너비 고정
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: ps.bottomNavigationBarIndex == null || ps.bottomNavigationBarIndex == 0 ? Colors.black : Colors.grey,
            ),
            label: '어항',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: ps.bottomNavigationBarIndex == 1 ? Colors.black : Colors.grey,
            ),
            label: '쇼핑',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
              color: ps.bottomNavigationBarIndex == 2 ? Colors.black : Colors.grey,
            ),
            label: '생물도감',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups, color: ps.bottomNavigationBarIndex == 3 ? Colors.black : Colors.grey),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: ps.bottomNavigationBarIndex == 4 ? Colors.black : Colors.grey),
            label: '내 정보',
          ),
        ],

        // 선택된 아이템의 아이콘 및 라벨 텍스트 색상
        selectedItemColor: Colors.grey[700],
        // 선택되지 않은 아이템의 아이콘 및 라벨 텍스트 색상
        unselectedItemColor: Colors.grey[700],
        backgroundColor: Colors.white,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (value) => onItemTapped(value, context, ps),
      ),
    );
  }
}

void onItemTapped(int index, BuildContext context, ParamStore ps) {
  if (index == 0) {
    Navigator.pushNamedAndRemoveUntil(context, "/main", (route) => false);
  } else if (index == 1 && ps.bottomNavigationBarIndex != index) {
    // Navigator.pushNamedAndRemoveUntil(context, Move.recommendPage, (route) => false);
  } else if (index == 2 && ps.bottomNavigationBarIndex != index) {
    // Navigator.pushNamedAndRemoveUntil(context, Move.bestPage, (route) => false);
  } else if (index == 3 && ps.bottomNavigationBarIndex != index) {
    // Navigator.pushNamedAndRemoveUntil(context, Move.myPage, (route) => false);
  } else if (index == 4 && ps.bottomNavigationBarIndex != index) {
    // Navigator.pushNamedAndRemoveUntil(context, Move.seeMorePage, (route) => false);
  } else {
    print("아무실행안됨");
    return;
  }

  ps.bottomNavigationBarIndex = index;
  print("${index}테스트${ps.bottomNavigationBarIndex}");
}
