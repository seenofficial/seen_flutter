import 'package:dartz/dartz.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';
import '../../../../../../core/errors/failure.dart';


abstract class BaseUserPropertiesRepository {
  Future<Either<Failure, List<PropertyEntity>>> getMyProperties({
    Map<String, dynamic>? filters,
  });
}