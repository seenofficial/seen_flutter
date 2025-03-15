import 'package:bloc/bloc.dart';
import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/features/my_profile/modules/user_appointments/domain/use_cases/cancel_appointment_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:enmaa/core/utils/enums.dart';

import '../../domain/entities/appointment_entity.dart';
import '../../domain/use_cases/get_user_appointments_use_case.dart';

part 'user_appointments_state.dart';

class UserAppointmentsCubit extends Cubit<UserAppointmentsState> {
  UserAppointmentsCubit(
      this.getUserAppointmentsUseCase, this.cancelAppointmentUseCase)
      : super(const UserAppointmentsState());

  final GetUserAppointmentsUseCase getUserAppointmentsUseCase;
  final CancelAppointmentUseCase cancelAppointmentUseCase;

  Future<void> getUserAppointments({
    required String status,
    required bool isRefresh,
  }) async {
    if (!isRefresh && !state.hasMoreAppointments(status)) {
      return;
    }

    final offset = isRefresh ? 0 : state.getOffsetForStatus(status);
    _updateStateBeforeRequest(status, isRefresh);

    final filters = {
      'status': status,
      'offset': offset,
      "order__status": status,
      'limit': state.limit,
    };

    final result = await getUserAppointmentsUseCase(filters: filters);

    result.fold(
          (failure) => _handleFailure(status, failure.message),
          (newAppointments) => _handleSuccess(
          status, List<AppointmentEntity>.from(newAppointments), isRefresh),
    );
  }

  Future<void> cancelAppointment(String appointmentId) async {
    emit(state.copyWith(cancelAppointmentState: RequestState.loading));

    final result = await cancelAppointmentUseCase(appointmentId);

    result.fold(
          (failure) {
        emit(state.copyWith(
          cancelAppointmentState: RequestState.error,
        ));
      },
          (message) {
            CustomSnackBar.show(message: message , type: SnackBarType.success) ;
        _moveAppointmentToCanceled(appointmentId);
      },
    );
  }

  void _moveAppointmentToCanceled(String appointmentId) {
    final pendingAppointments =
    List<AppointmentEntity>.from(state.getAppointmentsByStatus("pending"));

    final appointmentIndex =
    pendingAppointments.indexWhere((a) => a.id == appointmentId);

    if (appointmentIndex != -1) {
      final canceledAppointments =
      List<AppointmentEntity>.from(state.getAppointmentsByStatus("canceled"));

      final canceledAppointment = pendingAppointments.removeAt(appointmentIndex);
      canceledAppointments.add(canceledAppointment);

      emit(state.copyWith(
        appointments: {
          ...state.appointments,
          "pending": pendingAppointments,
          "canceled": canceledAppointments,
        },
        cancelAppointmentState: RequestState.loaded,
      ));
    }
  }

  void _updateStateBeforeRequest(String status, bool isRefresh) {
    if (!isRefresh) {
      emit(state.copyWith(isLoadingMore: true));
      return;
    }

    emit(state.copyWith(
      loadedStates: {...state.loadedStates, status: RequestState.loading},
      currentStatus: status,
    ));
  }

  void _handleFailure(String status, String errorMessage) {
    emit(state.copyWith(
      loadedStates: {...state.loadedStates, status: RequestState.error},
      errors: {...state.errors, status: errorMessage},
      isLoadingMore: false,
    ));
  }

  void _handleSuccess(
      String status, List<AppointmentEntity> newAppointments, bool isRefresh) {
    final hasReachedMax = newAppointments.length < state.limit;
    final currentAppointments =
    isRefresh ? <AppointmentEntity>[] : [...state.getAppointmentsByStatus(status)];
    final updatedAppointments = [...currentAppointments, ...newAppointments];
    final newOffset =
    isRefresh ? newAppointments.length : state.getOffsetForStatus(status) + newAppointments.length;

    emit(state.copyWith(
      appointments: {...state.appointments, status: updatedAppointments},
      offsets: {...state.offsets, status: newOffset},
      hasMore: {...state.hasMore, status: !hasReachedMax},
      loadedStates: {...state.loadedStates, status: RequestState.loaded},
      isLoadingMore: false,
    ));
  }
}
