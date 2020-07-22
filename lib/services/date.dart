class Date {
  //Singleton
  DateTime _date;

  static final Date _instance = Date._privateConstructor();

  factory Date() {
    return _instance;
  }

  Date._privateConstructor() {
    DateTime _now = DateTime.now();
    _date = DateTime(_now.day);
  }

  bool isNewDay() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.day);
    return (date != _date);
  }
}
