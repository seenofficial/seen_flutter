import 'package:dartz/dartz.dart';
import 'package:enmaa/features/real_estates/data/data_source/remote_data/real_estate_remote_data_source.dart';
import 'package:enmaa/features/real_estates/data/models/property_details_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_details_entity.dart';
import 'package:enmaa/features/real_estates/domain/entities/property_listing_entity.dart';
import 'package:enmaa/features/real_estates/domain/repository/base_real_estate_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/handle_api_request_service.dart';


class RealEstateRepository extends BaseRealEstateRepository{
  final BaseRealEstateRemoteData baseRealEstateRemoteData;

  RealEstateRepository({ required this.baseRealEstateRemoteData});


  @override
  Future<Either<Failure, List<PropertyListingEntity>>> getProperties() async{
    return await HandleRequestService.handleApiCall<List<PropertyListingEntity>>(() async {
      final result = await baseRealEstateRemoteData.getProperties();
      return result;
    });
  }

  @override
  Future<Either<Failure, PropertyDetailsEntity>> getPropertyDetails(String propertyId) async {
    return HandleRequestService.handleApiCall<PropertyDetailsEntity>(() async {
      final PropertyDetailsModel result = await baseRealEstateRemoteData.getPropertyDetails(propertyId);
      return result as PropertyDetailsEntity;
    });
  }




}