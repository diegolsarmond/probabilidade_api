extension DateTimeExtension on DateTime{
  static final _now = DateTime.now();
  DateTime firstDateOfWeek(){
    DateTime firstDayOfWeek = _now.subtract(Duration(days: _now.weekday % 7));
    return firstDayOfWeek;
  }
  DateTime lastDateOfWeek(){
    DateTime lastDayOfWeek = _now.firstDateOfWeek().add(const Duration(days: 6));
    return lastDayOfWeek;
  }
}