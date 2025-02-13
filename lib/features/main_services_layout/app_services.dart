import '../home_module/home_imports.dart';
import '../real_estates/presentation/screens/real_estates_screen.dart';

final Map<String, Widget Function(BuildContext)> appServiceScreens = {
  'عقارات': (context) => const RealStateScreen(),

};