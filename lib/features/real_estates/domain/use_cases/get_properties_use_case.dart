import 'package:dartz/dartz.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_listing_entity.dart';
import 'package:enmaa/features/real_estates/domain/repository/base_real_estate_repository.dart';
import '../../../../core/errors/failure.dart';

class GetPropertiesUseCase {
  final BaseRealEstateRepository _baseRealEstateRepository;

  GetPropertiesUseCase(this._baseRealEstateRepository);

  Future<Either<Failure, List<PropertyListingEntity>>> call( ) =>
      _baseRealEstateRepository.getProperties();
}