import 'package:dartz/dartz.dart';
import 'package:enmaa/core/errors/failure.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';
import 'package:enmaa/features/real_estates/domain/repository/base_real_estate_repository.dart';

class GetPropertiesUseCase {
  final BaseRealEstateRepository repository;

  GetPropertiesUseCase(this.repository);

  Future<Either<Failure, List<PropertyEntity>>> call() async {
    return await repository.getProperties();
  }
}