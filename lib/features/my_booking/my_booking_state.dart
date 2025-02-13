part of 'my_booking_cubit.dart';

sealed class MyBookingState extends Equatable {
  const MyBookingState();
}

final class MyBookingInitial extends MyBookingState {
  @override
  List<Object> get props => [];
}
