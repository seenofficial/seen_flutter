import 'package:dartz/dartz.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_listing_entity.dart';

import '../../../../core/errors/failure.dart';


abstract class BaseRealEstateRepository {
  Future<Either<Failure, List<PropertyListingEntity>>> getProperties();
  Future<Either<Failure, PropertyDetailsEntity>> getPropertyDetails(String propertyId);

}