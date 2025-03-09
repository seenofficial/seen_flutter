import 'dart:async';
import 'package:dio/dio.dart';
import 'package:enmaa/core/models/amenity_model.dart';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/building_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/land_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/villa_request_model.dart';


import '../../../../../core/constants/api_constants.dart';
import '../../../../core/entites/amenity_entity.dart';


abstract class BaseAddNewRealEstateDataSource {

  Future<void> addApartment(ApartmentRequestModel apartment);
  Future<void> addVilla(VillaRequestModel villa);
  Future<void> addBuilding(BuildingRequestModel building);
  Future<void> addLand(LandRequestModel land);


  Future<List<AmenityModel>> getPropertyAmenities(String propertyType);

}

class AddNewRealEstateRemoteDataSource extends BaseAddNewRealEstateDataSource {
  DioService dioService;

  AddNewRealEstateRemoteDataSource({required this.dioService});




  @override
  Future<void> addApartment(ApartmentRequestModel apartment) async {

    final formData = await apartment.toFormData();

    var res  = await dioService.post(
      url: ApiConstants.apartment,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  @override
  Future<void> addVilla(VillaRequestModel villa) async{
    final formData = await villa.toFormData();

    await dioService.post(
      url: ApiConstants.villa,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  @override
  Future<void> addBuilding(BuildingRequestModel building)async {
    final formData = await building.toFormData();

    await dioService.post(
      url: ApiConstants.building,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  @override
  Future<void> addLand(LandRequestModel land) async{
    final formData = await land.toFormData();

    await dioService.post(
      url: ApiConstants.land,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  @override
  Future<List<AmenityModel>> getPropertyAmenities(String propertyType) async {
    final response = await dioService.get(
      url: ApiConstants.amenities,
      queryParameters: {
        'property_type_ids': propertyType,
      },
    );

    final List<dynamic> data = response.data['results'];
    return data.map((json) => AmenityModel.fromJson(json)).toList();
  }




}
