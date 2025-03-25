import 'package:easy_localization/easy_localization.dart';

class DateFormatterService {
  static String locale = 'ar';
  static String getFormattedDate(String date) {
    final dateTime = DateTime.parse(date);
    final formatter = DateFormat(' dd MMMM , yyyy , hh:mm a', locale);
    String formattedDate = formatter.format(dateTime);

    if (locale == 'ar') {
      formattedDate = _convertToArabicNumerals(formattedDate);
    }

    return formattedDate;
  }

  static String _convertToArabicNumerals(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String result = input;
    for (int i = 0; i < english.length; i++) {
      result = result.replaceAll(english[i], arabic[i]);
    }
    return result;
  }
}