import 'package:fishfront/_core/constants/enum.dart';
import 'package:fishfront/data/dto/aquarium_dto.dart';
import 'package:fishfront/data/dto/comment_dto.dart';
import 'package:fishfront/data/dto/fish_dto.dart';
import 'package:fishfront/data/model/aquarium.dart';
import 'package:fishfront/data/model/user.dart';
import 'package:intl/intl.dart';

class EmoticonCount {
  EmoticonEnum? myEmoticonEnum;
  int countTHUMB;
  int countHEART;
  int countCONGRATATU;
  int countSMILE;
  int countCRY;
  int countANGRY;

  EmoticonCount(
    this.myEmoticonEnum,
    this.countTHUMB,
    this.countHEART,
    this.countCONGRATATU,
    this.countSMILE,
    this.countCRY,
    this.countANGRY,
  );

  EmoticonCount.fromJson(Map<String, dynamic> json)
      : myEmoticonEnum = json["myEmoticonEnum"] == "THUMB"
            ? EmoticonEnum.THUMB
            : json["myEmoticonEnum"] == "HEART"
                ? EmoticonEnum.HEART
                : json["myEmoticonEnum"] == "CONGRATATU"
                    ? EmoticonEnum.CONGRATATU
                    : json["myEmoticonEnum"] == "SMILE"
                        ? EmoticonEnum.SMILE
                        : json["myEmoticonEnum"] == "CRY"
                            ? EmoticonEnum.CRY
                            : json["myEmoticonEnum"] == "CRY"
                                ? EmoticonEnum.ANGRY
                                : null,
        countTHUMB = json["countTHUMB"],
        countHEART = json["countHEART"],
        countCONGRATATU = json["countCONGRATATU"],
        countSMILE = json["countSMILE"],
        countCRY = json["countCRY"],
        countANGRY = json["countANGRY"];

  @override
  String toString() {
    return 'EmoticonCount{myEmoticonEnum: $myEmoticonEnum, countTHUMB: $countTHUMB, countHEART: $countHEART, countCONGRATATU: $countCONGRATATU, countSMILE: $countSMILE, countCRY: $countCRY, countANGRY: $countANGRY}';
  }
}
