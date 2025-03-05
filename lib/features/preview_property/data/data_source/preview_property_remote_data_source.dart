import 'package:dio/dio.dart';
import 'package:enmaa/features/home_module/data/models/app_service_model.dart';
import 'package:enmaa/features/home_module/data/models/banner_model.dart';
import 'package:enmaa/features/preview_property/data/models/day_and_hours_model.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/entites/image_entity.dart';
import '../../../../../core/services/dio_service.dart';

abstract class BasePreviewPropertyDataSource {
  Future<List<DayAndHoursModel>> getPropertyPreviewAvailableHours(String propertyId);
  Future<String> getInspectionAmountToBePaid(String propertyId);

}

class PreviewPropertyRemoteDataSource extends BasePreviewPropertyDataSource {
  DioService dioService;

  PreviewPropertyRemoteDataSource({required this.dioService});



  @override
  Future<List<DayAndHoursModel>> getPropertyPreviewAvailableHours(String propertyId)async {
    final response = await dioService.get(
      url: '${ApiConstants.propertyBusyDays}/$propertyId/' ,
    );


    List<dynamic> jsonResponse = response.data;

    List<DayAndHoursModel> availableHours = jsonResponse.map((day) {
      return DayAndHoursModel.fromJson(day);
    }).toList();

    return availableHours ;


  }

  @override
  Future<String> getInspectionAmountToBePaid(String propertyId)async {
    final response = await dioService.get(
      url: '${ApiConstants.propertyOrderDetails}/$propertyId/' ,
    );


    return response.data['viewing_request_amount'].toString() ;

   }

}