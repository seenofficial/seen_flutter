import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:enmaa/core/errors/failure.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/use_cases/get_property_details_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/base_property_entity.dart';
import '../../domain/use_cases/get_properties_use_case.dart';

part 'real_estate_state.dart';

class RealEstateCubit extends Cubit<RealEstateState> {
  final GetPropertiesUseCase _getPropertiesUseCase;
  final GetPropertyDetailsUseCase _getPropertyDetailsUseCase;

  RealEstateCubit(this._getPropertiesUseCase , this._getPropertyDetailsUseCase) : super(const RealEstateState());

  Future<void> fetchProperties({Map<String, dynamic>? filters}) async {
    emit(state.copyWith(getPropertiesState: RequestState.loading));

    final Either<Failure, List<PropertyEntity>> result = await _getPropertiesUseCase(filters: filters);

    result.fold(
          (failure) => emit(state.copyWith(
        getPropertiesState: RequestState.error,
        getPropertiesError: failure.message,
      )),
          (properties) => emit(state.copyWith(
        getPropertiesState: RequestState.loaded,
        properties: properties,
      )),
    );
  }

  Future<void> fetchPropertyDetails(String propertyID) async {
    emit(state.copyWith(getPropertyDetailsState: RequestState.loading));

    final Either<Failure, BasePropertyDetailsEntity> result = await _getPropertyDetailsUseCase(propertyID);


    print("reekekek ${result}");

    result.fold(
          (failure) => emit(state.copyWith(
            getPropertyDetailsState: RequestState.error,
        getPropertyDetailsError: failure.message,
      )),
          (properties) => emit(state.copyWith(
            getPropertyDetailsState: RequestState.loaded,
        propertyDetails: properties,
      )),
    );
  }

}
