extension DoubleCurrencyExtension on double {
  int tryRound() {
    try{
      return round();
    }catch(_){
      return 0;
    }
  }
}
