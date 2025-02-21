import 'dart:async';
import 'package:dio/dio.dart';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';


import '../../../../../core/constants/api_constants.dart';


abstract class BaseAddNewRealEstateDataSource {

  Future<void> addApartment(ApartmentRequestModel apartment);
}

class AddNewRealEstateRemoteDataSource extends BaseAddNewRealEstateDataSource {
  DioService dioService;

  AddNewRealEstateRemoteDataSource({required this.dioService});




  @override
  Future<void> addApartment(ApartmentRequestModel apartment) async {

    final formData = await apartment.toFormData();

    await dioService.post(
      url: ApiConstants.apartments,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }



}
