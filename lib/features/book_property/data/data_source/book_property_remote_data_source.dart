import 'dart:async';
import 'package:dio/dio.dart';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/building_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/land_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/villa_request_model.dart';
import 'package:enmaa/features/book_property/data/models/property_sale_details_model.dart';


import '../../../../../core/constants/api_constants.dart';
import '../../../../core/entites/amenity_entity.dart';


abstract class BaseBookPropertyRemoteDataSource {


  Future<PropertySaleDetailsModel> getPropertySaleDetails(String propertyId);

}

class BookPropertyRemoteDataSource extends BaseBookPropertyRemoteDataSource {
  DioService dioService;

  BookPropertyRemoteDataSource({required this.dioService});





  @override
  Future<PropertySaleDetailsModel> getPropertySaleDetails(String propertyId) async{

    final response = await dioService.get(
      url: '${ApiConstants.propertyOrderDetails}/$propertyId/' ,
    );


    return PropertySaleDetailsModel.fromJson(response.data) ;



  }



}
