import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/entites/image_entity.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:enmaa/features/home_module/domain/use_cases/get_app_services_use_case.dart';
import 'package:enmaa/features/real_estates/domain/use_cases/get_properties_use_case.dart';
import 'package:enmaa/features/real_estates/real_estates_DI.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/json_keys.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/utils/enums.dart';
import '../../../real_estates/domain/entities/base_property_entity.dart';
import '../../domain/entities/app_service_entity.dart';
import '../../domain/entities/banner_entity.dart';
import '../../domain/use_cases/get_banners_use_case.dart';
import '../../domain/use_cases/update_user_location_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetBannersUseCase getBannersUseCase;
  final GetAppServicesUseCase getAppServicesUseCase;
  /// get near by properties for home screen
  final GetPropertiesUseCase getRealEstatesUseCase;
  final UpdateUserLocationUseCase updateUserLocationUseCase;

  HomeBloc(
      this.updateUserLocationUseCase ,
      this.getBannersUseCase, this.getAppServicesUseCase , this.getRealEstatesUseCase)
      : super(const HomeState()) {

    on<FetchBanners>(_onFetchBanners);
    on<FetchAppServices>(_onFetchAppServices);
    on<FetchNearByProperties>(_onFetchNearByProperties);


    on<AddPropertyToWishlist>(_onAddPropertyToWishlist);
    on<RemovePropertyFromWishlist>(_onRemovePropertyFromWishlist);
    on<UpdateUserLocation>(_onUpdateUserLocation);
    on<GetUserLocation>(_onGetUserLocation);


  }
  
  Future<void> _onGetUserLocation(
      GetUserLocation event,
      Emitter<HomeState> emit,
      ) async {

    emit(state.copyWith(
       userLocationState: RequestState.loading,
    ));
    SharedPreferences.getInstance().then((pref){
      String cityName = pref.getString('city_name')??'';

      emit(state.copyWith(
        selectedCityName: cityName,
        userLocationState: RequestState.loaded,
      ));
    });

  }

  Future<void> _onUpdateUserLocation(
      UpdateUserLocation event,
      Emitter<HomeState> emit,
      ) async {
    emit (state.copyWith(userLocationState: RequestState.loading));
    final Either<Failure, void> result = await updateUserLocationUseCase(event.cityID);

    result.fold(
          (failure) => emit(state.copyWith(
        userLocationState: RequestState.error,
        errorMessage: failure.message,
      )),
          (_) {
            SharedPreferences.getInstance().then((pref){

              pref.setString('city_name', event.cityName);
              pref.setString('city_id', event.cityID);


            });        emit(state.copyWith(
          selectedCityName: event.cityName,
          userLocationState: RequestState.loaded,
        ));
      },
    );
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



        List<AppServiceEntity> appServicessList = [
          AppServiceEntity(
            text: 'عقارات',
            image: AppAssets.aqarIcon,
          ),
          AppServiceEntity(
            text: 'السيارات',
            image: AppAssets.carIcon,
          ),
          AppServiceEntity(
            text: 'القاعات',
            image: AppAssets.hallIcon,
          ),
          AppServiceEntity(
            text: ' الفنادق',
            image: AppAssets.hotelIcon,
          ),
          AppServiceEntity(
            text: ' الفنادق',
            image: AppAssets.hotelIcon,
          ),

        ];
        // Add the new entity to the list

        // Emit the new state
        emit(state.copyWith(
          appServicesState: RequestState.loaded,
          appServices: appServicessList,
        ));
      },
    );

  }

  Future<void> _onFetchNearByProperties(
      FetchNearByProperties event, Emitter<HomeState> emit) async {
    final propertyType = event.propertyType;

    print("prorororo ${propertyType}");


    emit(state.copyWith(
      properties: {
        ...state.properties,
        propertyType: PropertyData(state: RequestState.loading),
      },
    ));

    final Either<Failure, List<PropertyEntity>> result = await getRealEstatesUseCase(
      filters:
      {
        JsonKeys.propertyTypeName: propertyType.toEnglish,
        JsonKeys.limit : event.numberOfProperties,
        JsonKeys.offset  : 0,
        JsonKeys.country : event.location,
      }
    );

    print("Fetched properties: $result");
    result.fold(
          (failure) {
        emit(state.copyWith(
          properties: {
            ...state.properties,
            propertyType: PropertyData(
              state: RequestState.error,
              errorMessage: failure.message,
            ),
          },
        ));
      },
          (properties) {
        emit(state.copyWith(
          properties: {
            ...state.properties,
            propertyType: PropertyData(
              state: RequestState.loaded,
              properties: properties,
            ),
          },
        ));
      },
    );
  }


  Future<void> _onAddPropertyToWishlist(
      AddPropertyToWishlist event, Emitter<HomeState> emit) async {
    final propertyType = event.propertyType;
    final propertyId = event.propertyId;

    // Get current properties for this type
    final PropertyData? propertyData = state.properties[propertyType];

    if (propertyData == null || propertyData.state != RequestState.loaded) {
      return; // Do nothing if data isn't loaded yet
    }

    // Create updated list with the property marked as in wishlist
    final List<PropertyEntity> updatedProperties = propertyData.properties.map((property) {
      if (property.id.toString() == propertyId) {
        return property.copyWith(isInWishlist: true);
      } else {
        return property;
      }
    }).toList();

    // Update the state with optimistic result
    emit(state.copyWith(
      properties: {
        ...state.properties,
        propertyType: PropertyData(
          state: RequestState.loaded,
          properties: updatedProperties,
          errorMessage: propertyData.errorMessage,
        ),
      },
    ));

    // Here you would typically call an API to add to wishlist
    // If API fails, you can emit another event to revert the change
  }

  Future<void> _onRemovePropertyFromWishlist(
      RemovePropertyFromWishlist event, Emitter<HomeState> emit) async {
    final propertyType = event.propertyType;
    final propertyId = event.propertyId;

    // Get current properties for this type
    final PropertyData? propertyData = state.properties[propertyType];

    if (propertyData == null || propertyData.state != RequestState.loaded) {
      return; // Do nothing if data isn't loaded yet
    }

    // Create updated list with the property marked as not in wishlist
    final List<PropertyEntity> updatedProperties = propertyData.properties.map((property) {
      if (property.id.toString() == propertyId) {
        return property.copyWith(isInWishlist: false);
      } else {
        return property;
      }
    }).toList();

    // Update the state with optimistic result
    emit(state.copyWith(
      properties: {
        ...state.properties,
        propertyType: PropertyData(
          state: RequestState.loaded,
          properties: updatedProperties,
          errorMessage: propertyData.errorMessage,
        ),
      },
    ));
    }
}