import 'package:intl/intl.dart';

final vnCurrencyFormat = NumberFormat.currency(
  locale: 'en-US',
  decimalDigits: 0,
  symbol: 'đ',
  customPattern: '###,### ¤',
);

final vnCurrencyFormatWithoutSymbol = NumberFormat.currency(
  locale: 'en-US',
  decimalDigits: 0,
  customPattern: '###,###',
);
