import 'package:dartz/dartz.dart';
import 'package:enmaa/features/preview_property/domain/entities/day_and_hours_entity.dart';

import '../../../../core/errors/failure.dart';



abstract class BasePreviewPropertyRepository {




  Future<Either<Failure, List<DayAndHoursEntity>>> getPropertyPreviewAvailableHours(String propertyId);
  Future<Either<Failure, String>> getInspectionAmountToBePaid(String propertyId);


}