import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime parseDateTime(String strDate) => DateTime.parse(strDate);

DateFormat formatDateTime(String format) => DateFormat(format);

String dateFormatted({required String date, required String formatType}) =>
    formatDateTime(formatType).format(parseDateTime(date));

enum FormatType {
  dateTime,
  date,
  time,
  ddMMMYYYY,
}

String formatForDateTime(FormatType formatType) {
  switch (formatType) {
    case FormatType.date:
      {
        return "EEEE, d MMM";
      }
    case FormatType.dateTime:
      {
        return "dd-MM-yyyy hh:mm a";
      }
    case FormatType.time:
      {
        return "hh:mm a";
      }
    case FormatType.ddMMMYYYY:
      {
        return "dd MMM,yyyy";
      }
    default:
      {
        return "";
      }
  }
}

double parseWcPrice(String? price) => (double.tryParse(price ?? "0") ?? 0);

enum SymbolPositionType { left, right }

const SymbolPositionType appCurrencySymbolPosition = SymbolPositionType.left;

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF${hex.toUpperCase().replaceAll("#", "")}";
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}

class ConvertHexColor {
  static String getColor(Color myColor) {
    var hex = '#${myColor.value.toRadixString(16)}';
    return hex.replaceFirst('ff', '');
  }
}
