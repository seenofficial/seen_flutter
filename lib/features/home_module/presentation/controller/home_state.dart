part of 'home_bloc.dart';

class HomeState extends Equatable {
  final RequestState bannersState;
  final RequestState appServicesState;
  final List<ImageEntity> banners;
  final List<AppServiceEntity> appServices;
  final String errorMessage;

  final Map<PropertyType, PropertyData> properties;

  final String selectedCityName;
  final RequestState updateUserLocationState ;

  const HomeState({
    this.bannersState = RequestState.initial,
    this.appServicesState = RequestState.initial,
    this.updateUserLocationState = RequestState.initial,
    this.banners = const [],
    this.appServices = const [],
    this.errorMessage = '',
    this.properties = const {},
    this.selectedCityName = '' ,
  });

  HomeState copyWith({
    RequestState? bannersState,
    RequestState? appServicesState,
    RequestState? userLocationState,
    List<ImageEntity>? banners,
    List<AppServiceEntity>? appServices,
    String? errorMessage,
    Map<PropertyType, PropertyData>? properties,
    String ?selectedCityName ,
  }) {
    return HomeState(
      bannersState: bannersState ?? this.bannersState,
      appServicesState: appServicesState ?? this.appServicesState,
      updateUserLocationState: userLocationState ?? this.updateUserLocationState,
      banners: banners ?? this.banners,
      appServices: appServices ?? this.appServices,
      errorMessage: errorMessage ?? this.errorMessage,
      properties: properties ?? this.properties,
      selectedCityName: selectedCityName ?? this.selectedCityName,
    );
  }

  @override
  List<Object?> get props => [
    bannersState,
    appServicesState,
    banners,
    appServices,
    errorMessage,
    properties,
    updateUserLocationState,
    selectedCityName
  ];
}

class PropertyData extends Equatable {
  final List<PropertyEntity> properties;
  final RequestState state;
  final String errorMessage;

  const PropertyData({
    this.properties = const [],
    this.state = RequestState.initial,
    this.errorMessage = '',
  });

  PropertyData copyWith({
    List<PropertyEntity>? properties,
    RequestState? state,
    String? errorMessage,
  }) {
    return PropertyData(
      properties: properties ?? this.properties,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [properties, state, errorMessage];
}
