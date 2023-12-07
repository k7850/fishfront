import 'package:fishfront/_core/constants/enum.dart';
import 'package:intl/intl.dart';

class EmoticonDTO {
  EmoticonEnum? deleteEmoticon;
  EmoticonEnum? createEmoticon;

  EmoticonDTO(this.deleteEmoticon, this.createEmoticon);

  EmoticonDTO.fromJson(Map<String, dynamic> json)
      : deleteEmoticon = json["deleteEmoticon"] == "THUMB"
            ? EmoticonEnum.THUMB
            : json["deleteEmoticon"] == "HEART"
                ? EmoticonEnum.HEART
                : json["deleteEmoticon"] == "CONGRATATU"
                    ? EmoticonEnum.CONGRATATU
                    : json["deleteEmoticon"] == "SMILE"
                        ? EmoticonEnum.SMILE
                        : json["deleteEmoticon"] == "CRY"
                            ? EmoticonEnum.CRY
                            : json["deleteEmoticon"] == "ANGRY"
                                ? EmoticonEnum.ANGRY
                                : null,
        createEmoticon = json["createEmoticon"] == "THUMB"
            ? EmoticonEnum.THUMB
            : json["createEmoticon"] == "HEART"
                ? EmoticonEnum.HEART
                : json["createEmoticon"] == "CONGRATATU"
                    ? EmoticonEnum.CONGRATATU
                    : json["createEmoticon"] == "SMILE"
                        ? EmoticonEnum.SMILE
                        : json["createEmoticon"] == "CRY"
                            ? EmoticonEnum.CRY
                            : json["createEmoticon"] == "ANGRY"
                                ? EmoticonEnum.ANGRY
                                : null;

  @override
  String toString() {
    return 'EmoticonDTO{deleteEmoticon: $deleteEmoticon, createEmoticon: $createEmoticon}';
  }
}
