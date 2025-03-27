import 'package:enmaa/core/services/shared_preferences_service.dart';

class NumbersServices {
  static String relocatePlusInNumber(String englishNumber , String currentLang) {
    if(currentLang != 'ar') return englishNumber;
    bool hasPlus = englishNumber.startsWith('+');
    String numberPart = hasPlus ? englishNumber.substring(1) : englishNumber;
    String convertedNumber = numberPart;

    return hasPlus ? '$convertedNumber +' : convertedNumber;
  }
}