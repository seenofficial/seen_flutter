import 'package:shared_preferences/shared_preferences.dart';

import '../../configuration/routers/route_names.dart';
import '../home_module/home_imports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('access_token');

                Navigator.of(context).pushReplacementNamed(RoutersNames.authenticationFlow);
              },
              child: const Text('تسجيل الخروج'),
            ),
          ],
        ),
      ),
    );
  }
}
