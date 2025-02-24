import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

class LandEntity extends PropertyEntity {
  final bool isLicensed;
  const LandEntity({
    required super.id,
    required super.title,
    required super.image,
    required super.propertyType,
    required super.operation,
    required super.price,
    required super.area,
    required super.propertySubType,
    required super.status,
    required super.city,
    required super.state,
    required super.country,
    required super.isInWishlist,
    required this.isLicensed,
  });

  @override
  List<Object?> get props => [...super.props , isLicensed];
}