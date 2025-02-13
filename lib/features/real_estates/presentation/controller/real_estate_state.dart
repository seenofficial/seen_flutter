part of 'real_estate_cubit.dart';

class RealEstateState extends Equatable {
  const RealEstateState({
    this.getPropertiesState = RequestState.initial,
    this.getPropertiesError = '',
    this.properties = const [],
    this.getPropertyDetailsState = RequestState.initial,
    this.getPropertyDetailsError = '',
    this.propertyDetails ,
  });

  // Properties list
  final RequestState getPropertiesState;
  final List<PropertyListingEntity> properties;
  final String getPropertiesError;

  // Property details
  final RequestState getPropertyDetailsState;
  final PropertyDetailsEntity? propertyDetails;
  final String getPropertyDetailsError;

  RealEstateState copyWith({
    RequestState? getPropertiesState,
    List<PropertyListingEntity>? properties,
    String? getPropertiesError,
    RequestState? getPropertyDetailsState,
    PropertyDetailsEntity? propertyDetails,
    String? getPropertyDetailsError,
  }) {
    return RealEstateState(
      getPropertiesState: getPropertiesState ?? this.getPropertiesState,
      properties: properties ?? this.properties,
      getPropertiesError: getPropertiesError ?? this.getPropertiesError,
      getPropertyDetailsState: getPropertyDetailsState ?? this.getPropertyDetailsState,
      propertyDetails: propertyDetails ?? this.propertyDetails,
      getPropertyDetailsError: getPropertyDetailsError ?? this.getPropertyDetailsError,
    );
  }

  @override
  List<Object?> get props => [
    getPropertiesState,
    properties,
    getPropertiesError,
    getPropertyDetailsState,
    propertyDetails,
    getPropertyDetailsError,
  ];
}
