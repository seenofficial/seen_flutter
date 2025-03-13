import 'package:bloc/bloc.dart';
import 'package:enmaa/core/extensions/booking_status_extension.dart';
import 'package:enmaa/core/extensions/status_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/services/convert_string_to_enum.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../real_estates/domain/entities/base_property_entity.dart';
import '../../domain/use_cases/get_my_properties_use_case.dart';

part 'user_properties_state.dart';


class UserPropertiesCubit extends Cubit<UserPropertiesState> {
  UserPropertiesCubit(this.getMyPropertiesUseCase) : super(const UserPropertiesState());

  final GetUserPropertiesUseCase getMyPropertiesUseCase;

  Future<void> getMyProperties({
    required String status,
    required bool isRefresh,
  }) async {
    if (!isRefresh && !state.hasMoreProperties(status)) {
      return;
    }

    final offset = isRefresh ? 0 : state.getOffsetForStatus(status);
    _updateStateBeforeRequest(status, isRefresh);

    String currentStatus = getBookingStatus(status).toJson();
    final filters = {
      'owner': true,
      'property_status': currentStatus,
      'offset': offset,
      'limit': state.limit,
    };

    final result = await getMyPropertiesUseCase(filters: filters);

    result.fold(
          (failure) => _handleFailure(status, failure.message),
          (newProperties) => _handleSuccess(status, List<PropertyEntity>.from(newProperties), isRefresh),
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

  void _handleSuccess(String status, List<PropertyEntity> newProperties, bool isRefresh) {
    final hasReachedMax = newProperties.length < state.limit;
    final currentProperties = isRefresh ? <PropertyEntity>[] : [...state.getPropertiesByStatus(status)];
    final updatedProperties = [...currentProperties, ...newProperties];
    final newOffset = isRefresh ? newProperties.length : state.getOffsetForStatus(status) + newProperties.length;

    emit(state.copyWith(
      properties: {...state.properties, status: updatedProperties},
      offsets: {...state.offsets, status: newOffset},
      hasMore: {...state.hasMore, status: !hasReachedMax},
      loadedStates: {...state.loadedStates, status: RequestState.loaded},
      isLoadingMore: false,
    ));
  }
}