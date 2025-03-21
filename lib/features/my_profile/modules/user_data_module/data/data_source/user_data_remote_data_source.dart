import 'package:dio/dio.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/my_profile/modules/user_data_module/data/model/user_data_model.dart';
import 'package:enmaa/features/real_estates/data/models/property_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/services/convert_string_to_enum.dart';
import '../../../../../../core/services/dio_service.dart';

abstract class BaseUserDataRemoteDataSource {
  Future<UserDataModel> getUserData( );
  Future<void> updateUserData(Map<String , dynamic> updatedData);
}

class UserDataRemoteDataSource extends BaseUserDataRemoteDataSource {
  DioService dioService;

  UserDataRemoteDataSource({required this.dioService});




  @override
  Future<UserDataModel> getUserData()async {
    final response = await dioService.get(
      url: ApiConstants.user,
    );

    return UserDataModel.fromJson(response.data);
  }

  @override
  Future<void> updateUserData(Map<String, dynamic> updatedData) async {

    FormData formData = FormData.fromMap(updatedData);

    final response = await dioService.patch(
      url: ApiConstants.user,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }



}