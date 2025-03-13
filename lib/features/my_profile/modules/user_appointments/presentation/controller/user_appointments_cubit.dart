import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
 import 'package:enmaa/core/utils/enums.dart';

import '../../domain/entities/appointment_entity.dart';
import '../../domain/use_cases/get_user_appointments_use_case.dart';

part 'user_appointments_state.dart';

class UserAppointmentsCubit extends Cubit<UserAppointmentsState> {
  UserAppointmentsCubit(this.getUserAppointmentsUseCase) : super(const UserAppointmentsState());

  final GetUserAppointmentsUseCase getUserAppointmentsUseCase;

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
      'limit': state.limit,
    };

    final result = await getUserAppointmentsUseCase(filters: filters);

    result.fold(
          (failure) => _handleFailure(status, failure.message),
          (newAppointments) => _handleSuccess(status, List<AppointmentEntity>.from(newAppointments), isRefresh),
    );
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

  void _handleSuccess(String status, List<AppointmentEntity> newAppointments, bool isRefresh) {
    final hasReachedMax = newAppointments.length < state.limit;
    final currentAppointments = isRefresh ? <AppointmentEntity>[] : [...state.getAppointmentsByStatus(status)];
    final updatedAppointments = [...currentAppointments, ...newAppointments];
    final newOffset = isRefresh ? newAppointments.length : state.getOffsetForStatus(status) + newAppointments.length;

    emit(state.copyWith(
      appointments: {...state.appointments, status: updatedAppointments},
      offsets: {...state.offsets, status: newOffset},
      hasMore: {...state.hasMore, status: !hasReachedMax},
      loadedStates: {...state.loadedStates, status: RequestState.loaded},
      isLoadingMore: false,
    ));
  }
}