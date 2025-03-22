import '../../../../../../core/components/app_bar_component.dart';
import '../../../../../home_module/home_imports.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const AppBarComponent(
            appBarTextMessage: 'تواصل معنا',
            showNotificationIcon: false,
            showLocationIcon: false,
            centerText: true,
            showBackIcon: true,
          ),


        ],
      ),
    );
  }
}
