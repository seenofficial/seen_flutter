part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchBanners extends HomeEvent {}

class FetchAppServices extends HomeEvent {}

class FetchNearByProperties extends HomeEvent {
  final PropertyType propertyType;
  final String location;
  final int numberOfProperties;

  const FetchNearByProperties({
    required this.propertyType,
    required this.location,
    this.numberOfProperties = 15,
  });
}

class AddPropertyToWishlist extends HomeEvent {
  final String propertyId;
  final PropertyType propertyType;

  const AddPropertyToWishlist({required this.propertyId, required this.propertyType});

  @override
  List<Object> get props => [propertyId, propertyType];
}

class RemovePropertyFromWishlist extends HomeEvent {
  final String propertyId;
  final PropertyType propertyType;

  const RemovePropertyFromWishlist({required this.propertyId, required this.propertyType});

  @override
  List<Object> get props => [propertyId, propertyType];
}