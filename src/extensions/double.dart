import 'package:intl/intl.dart';

extension DoubleCurrencyExtension on double {
  String toCurrencyString() {
    var format = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return format.format(this);
  }

  int tryRound() {
    try{
      return round();
    }catch(_){
      return 0;
    }
  }
}
