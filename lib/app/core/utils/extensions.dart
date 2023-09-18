import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../navigation/custom_navigation.dart';
import '../../localization/provider/localization_provider.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

extension TimerFormatter on num {
  String get toTimerFormatter {
    print(this);
    int h = (this ~/ 3600);
    int m = ((toInt() - h * 3600)) ~/ 60;
    int s = toInt() - (h * 3600) - (m * 60);
    if (h == 0) h = 00;
    if (m == 0) m = 00;
    if (s == 0) s = 00;
    if (h == 0) {
      return "$m:${s.toString().padLeft(2, "0")}";
    } else {
      return "$h:${m.toString().padLeft(2, "0")}:${s.toString().padLeft(2, "0")}";
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  Color get toColor {
    String colorStr = this;
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            "An error occurred when converting a color");
      }
    }
    return Color(val);
  }

  String hiddenNumber() {
    return this[length - 2] + this[length - 1] + "*" * (length - 2);
  }

  String hiddenEmail() {
    return "${this[0]}${this[1]}${"*" * (length - 6)}.com";
  }
}

extension DateExtention on DateTime {
  String dateFormat({required String format, String? lang}) {
    return DateFormat(format, lang).format(this);
  }

  String arTimeFormat() {
    return DateFormat("hh,mm aa").format(this);
  }
}

extension DefaultFormat on DateTime {
  String defaultFormat() {
    return DateFormat("d MMM yyyy").format(this);
  }

  String defaultFormat2() {
    return DateFormat("yyyy-MM-d").format(this);
  }
}

String localeCode = Provider.of<LocalizationProvider>(
        CustomNavigator.navigatorState.currentContext!,
        listen: false)
    .locale
    .languageCode;

extension ConvertDigits on String {
  String convertDigits() {
    var sb = StringBuffer();
    if (localeCode == "en") {
      return this;
    } else {
      for (int i = 0; i < length; i++) {
        switch (this[i]) {
          case '0':
            sb.write('٠');
            break;
          case '1':
            sb.write('۱');
            break;
          case '2':
            sb.write('۲');
            break;
          case '3':
            sb.write('۳');
            break;
          case '4':
            sb.write('٤');
            break;
          case '5':
            sb.write('٥');
            break;
          case '6':
            sb.write('٦');
            break;
          case '7':
            sb.write('٧');
            break;
          case '8':
            sb.write('۸');
            break;
          case '9':
            sb.write('۹');
            break;
          default:
            sb.write(this[i]);
            break;
        }
      }
    }
    return sb.toString();
  }
}

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get toPadding => MediaQuery.of(this).viewPadding.top;

  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}
