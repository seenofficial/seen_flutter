import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:enmaa/core/entites/image_entity.dart';
import 'package:enmaa/features/home_module/domain/use_cases/get_app_services_use_case.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/utils/enums.dart';
import '../../domain/entities/app_service_entity.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/use_cases/get_banners_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBannersUseCase getBannersUseCase;
  final GetAppServicesUseCase getAppServicesUseCase;

  HomeBloc(this.getBannersUseCase, this.getAppServicesUseCase)
      : super(const HomeState()) {
    on<FetchBanners>(_onFetchBanners);
    on<FetchAppServices>(_onFetchAppServices);
  }

  Future<void> _onFetchBanners(
      FetchBanners event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(bannersState: RequestState.loading));

    final Either<Failure, List<ImageEntity>> result =
    await getBannersUseCase();

    result.fold(
          (failure) => emit(state.copyWith(
        bannersState: RequestState.error,
        errorMessage: failure.message,
      )),
          (banners) {
        emit(state.copyWith(
          bannersState: RequestState.loaded,
          banners: banners,
        ));
      },
    );
  }

  Future<void> _onFetchAppServices(
      FetchAppServices event,
      Emitter<HomeState> emit,
      ) async {
    emit(state.copyWith(appServicesState: RequestState.loading));

    final Either<Failure, List<AppServiceEntity>> result =
    await getAppServicesUseCase();

    result.fold(
          (failure) {
        // Handle error case
        emit(state.copyWith(
          appServicesState: RequestState.error,
          errorMessage: failure.message,
        ));
      },
          (appServices) {
        // Assuming appServices is of type List<AppServiceEntity>
        List<AppServiceEntity> appServicess = List.from(appServices); // Ensure you clone the list

        // Create a new AppServiceEntity for "عقارات"
        AppServiceEntity aqarService = AppServiceEntity(
          text: 'عقارات',
          image: 'https://www.princehotels.com/wp-content/uploads/2019/05/hotel3.jpg',
        );

        // Add the new entity to the list
        appServicess.add(aqarService);

        // Emit the new state
        emit(state.copyWith(
          appServicesState: RequestState.loaded,
          appServices: appServicess,
        ));
      },
    );

  }
}