import 'dart:async';
import 'package:dio/dio.dart';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/building_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/land_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/villa_request_model.dart';


import '../../../../../core/constants/api_constants.dart';


abstract class BaseAddNewRealEstateDataSource {

  Future<void> addApartment(ApartmentRequestModel apartment);
  Future<void> addVilla(VillaRequestModel villa);
  Future<void> addBuilding(BuildingRequestModel building);
  Future<void> addLand(LandRequestModel land);
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



}
