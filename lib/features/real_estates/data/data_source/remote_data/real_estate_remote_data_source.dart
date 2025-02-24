import 'package:enmaa/features/real_estates/data/models/apartment_model.dart';
import 'package:enmaa/features/real_estates/data/models/property_details_model.dart';
import 'package:enmaa/features/real_estates/data/models/property_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/services/dio_service.dart';
import '../../../domain/entities/property_details_entity.dart';

abstract class BaseRealEstateRemoteData {
  Future<List<PropertyEntity>> getProperties();
  Future<BasePropertyDetailsEntity> getPropertyDetails(String propertyId);
}

class RealEstateRemoteDataSource extends BaseRealEstateRemoteData {
  DioService dioService;

  RealEstateRemoteDataSource({required this.dioService});


  @override
  Future<List<PropertyEntity>> getProperties() async {
    final response = await dioService.get(
        url: ApiConstants.properties
    );
    // Extract the list from the "results" key
    List<dynamic> jsonResponse = response.data['results'] ?? [];

    List<PropertyEntity> properties = jsonResponse.map((jsonItem) {
      return PropertyModel.fromJson(jsonItem);
    }).toList();

    print("properties: ${properties.length}");
    return properties;
  }


  @override
  Future<BasePropertyDetailsEntity> getPropertyDetails(String propertyId) async{
    final response = await dioService.get(
      url: '${ApiConstants.properties}$propertyId',
    );

    return PropertyDetailsModel.fromJson(response.data);
  }

}