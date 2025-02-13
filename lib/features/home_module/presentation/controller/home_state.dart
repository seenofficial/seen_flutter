part of 'home_bloc.dart';

class HomeState extends Equatable {
  final RequestState bannersState;
  final RequestState appServicesState;
  final List<ImageEntity> banners;
  final List<AppServiceEntity> appServices;
  final String errorMessage;

  const HomeState({
    this.bannersState = RequestState.initial,
    this.appServicesState = RequestState.initial,
    this.banners = const [],
    this.appServices = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    RequestState? bannersState,
    RequestState? appServicesState,
    List<ImageEntity>? banners,
    List<AppServiceEntity>? appServices,
    String? errorMessage,
  }) {
    return HomeState(
      bannersState: bannersState ?? this.bannersState,
      appServicesState: appServicesState ?? this.appServicesState,
      banners: banners ?? this.banners,
      appServices: appServices ?? this.appServices,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    bannersState,
    appServicesState,
    banners,
    appServices,
    errorMessage,
  ];
}