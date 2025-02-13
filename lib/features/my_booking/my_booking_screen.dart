import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_module/home_imports.dart';
import 'my_booking_cubit.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MyBookingCubit, MyBookingState>(
        builder: (context, state) {
          return Center(
            child: Text('My Booking Screen'),
          );
        },
      ),
    );
  }
}
