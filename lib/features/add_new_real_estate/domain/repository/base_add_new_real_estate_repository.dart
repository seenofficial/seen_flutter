import 'package:dartz/dartz.dart';
import 'package:enmaa/core/entites/amenity_entity.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/building_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/land_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/villa_request_model.dart';

import '../../../../core/errors/failure.dart';



abstract class BaseAddNewRealEstateRepository {


  Future<Either<Failure, void>> addNewApartment(ApartmentRequestModel apartment);
  Future<Either<Failure, void>> addNewVilla(VillaRequestModel villa);
  Future<Either<Failure, void>> addNewBuilding(BuildingRequestModel building);
  Future<Either<Failure, void>> addNewLand(LandRequestModel land);

  Future<Either<Failure, List<AmenityEntity>>> getPropertyAmenities(String propertyType);


}