import 'package:dio/dio.dart';
import 'package:enmaa/features/my_profile/modules/user_appointments/data/models/appointment_model.dart';
import 'package:enmaa/features/real_estates/data/models/property_model.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';

import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/services/dio_service.dart';

abstract class BaseUserAppointmentsRemoteData {
  Future<List<AppointmentModel>> getUserAppointments({Map<String, dynamic>? filters});
}

class UserAppointmentsRemoteDataSource extends BaseUserAppointmentsRemoteData {
  DioService dioService;

  UserAppointmentsRemoteDataSource({required this.dioService});



  @override
  Future<List<AppointmentModel>> getUserAppointments({Map<String, dynamic>? filters}) async{
    final response = await dioService.get(
      url: ApiConstants.appointments,
      queryParameters: filters,
      options: Options(contentType: 'multipart/form-data'),
    );

    List<dynamic> jsonResponse = response.data['results'] ?? [];

    List<AppointmentModel> properties = jsonResponse.map((jsonItem) {
      return AppointmentModel.fromJson(jsonItem);
    }).toList();

    return properties;
  }



}