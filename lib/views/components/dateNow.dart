enum Days { Empty, Lun, Mar, Mie, Joi, Vin, Sam, Dum }
enum Months {
  Empty,
  Ian,
  Feb,
  Mar,
  Apr,
  Mai,
  Iun,
  Iul,
  Aug,
  Sep,
  Oct,
  Noi,
  Dec
}

String getDateNow() {
  String date = Days.values[DateTime.now().weekday].toString().split('.').last +
      " " +
      DateTime.now().day.toString() +
      " " +
      Months.values[DateTime.now().month].toString().split('.').last;
  return date;
}
