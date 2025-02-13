import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_booking_state.dart';

class MyBookingCubit extends Cubit<MyBookingState> {
  MyBookingCubit() : super(MyBookingInitial());
}
