import 'package:intl/intl.dart';

class FormatDateTime {
  static DateFormat formatterDay = DateFormat('dd/MM/yyyy');
  static DateFormat formatterDayToID = DateFormat('ddMMyyyy');
  static DateFormat formatterDayAndMonth = DateFormat('d MMM');
  static DateFormat formatterTime = DateFormat('HH:mm');
  static DateFormat formatterDateTime = DateFormat('dd/MM/yyyy -- HH:mm');
  static DateFormat formatterBillID = DateFormat('ddMMyyyyHHmm');
}
