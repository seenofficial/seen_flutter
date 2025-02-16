import 'package:enmaa/features/real_estates/data/models/property_details_model.dart';
import 'package:enmaa/features/real_estates/data/models/property_listing_model.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/services/dio_service.dart';

abstract class BaseRealEstateRemoteData {
  Future<List<PropertyListingModel>> getProperties();
  Future<PropertyDetailsModel> getPropertyDetails(String propertyId);

}

class RealEstateRemoteDataSource extends BaseRealEstateRemoteData {
  DioService dioService;

  RealEstateRemoteDataSource({required this.dioService});


  @override
  Future<List<PropertyListingModel>> getProperties() async{
    final response = await dioService.get(
      url: ApiConstants.properties,
    );

    List<dynamic> jsonResponse = response.data ?? [];

    List<PropertyListingModel> properties = jsonResponse.map((banner) {
      return PropertyListingModel.fromJson(banner);
    }).toList();

    return properties ;
  }

  @override 
  Future<PropertyDetailsModel> getPropertyDetails(String propertyId) async{
    final response = await dioService.get(
      url: '${ApiConstants.properties}$propertyId',
    );

    dynamic jsonResponse = response.data ?? {};
    return PropertyDetailsModel.fromJson(jsonResponse);
  }

}