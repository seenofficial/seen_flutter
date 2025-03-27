import 'package:easy_localization/easy_localization.dart';
import '../../core/translation/locale_keys.dart';
import '../home_module/home_imports.dart';
import '../real_estates/presentation/screens/real_estates_screen.dart';

final Map<String, Widget Function(BuildContext)> appServiceScreens = {
  LocaleKeys.realEstate.tr(): (context) => const RealStateScreen(),

};