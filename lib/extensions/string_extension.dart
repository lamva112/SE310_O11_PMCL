import 'package:intl/intl.dart';

extension StringExtenstion on String? {
  String? covertToAppDateTime({
    String fromPattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    String toPattern = 'MM/dd/yyyy',
  }) {
    if (this != null && this!.isNotEmpty && this != '') {
      DateTime parseDate = DateFormat(fromPattern).parse(this ?? '');
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(toPattern);
      var outputDate = outputFormat.format(inputDate);

      return outputDate.toString();
    }

    return null;
  }
}
