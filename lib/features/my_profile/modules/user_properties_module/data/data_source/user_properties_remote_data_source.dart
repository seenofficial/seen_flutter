import 'package:dio/dio.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/real_estates/data/models/property_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/services/convert_string_to_enum.dart';
import '../../../../../../core/services/dio_service.dart';

abstract class BaseUserPropertiesRemoteData {
  Future<List<PropertyEntity>> getUserProperties({Map<String, dynamic>? filters});
  Future<void> deleteProperty(String propertyID , PropertyType propertyType);
}

class UserPropertiesRemoteDataSource extends BaseUserPropertiesRemoteData {
  DioService dioService;

  UserPropertiesRemoteDataSource({required this.dioService});



  @override
  Future<List<PropertyEntity>> getUserProperties({Map<String, dynamic>? filters}) async{
    final response = await dioService.get(
      url: ApiConstants.properties,
      queryParameters: filters,
      options: Options(contentType: 'multipart/form-data'),
    );

    List<dynamic> jsonResponse = response.data['results'] ?? [];

    List<PropertyEntity> properties = jsonResponse.map((jsonItem) {
      return PropertyModel.fromJson(jsonItem);
    }).toList();

    return properties;
  }

  @override
  Future<void> deleteProperty(String propertyID, PropertyType propertyType) async{
     await dioService.delete(
      url: '${ApiConstants.baseUrl}${propertyType.toEnglish}s/$propertyID/',
      options: Options(contentType: 'multipart/form-data'),
    );

  }



}