import 'package:dio/dio.dart';
import 'package:enmaa/features/home_module/data/models/app_service_model.dart';
import 'package:enmaa/features/home_module/data/models/banner_model.dart';
import 'package:enmaa/features/preview_property/data/models/day_and_hours_model.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/entites/image_entity.dart';
import '../../../../../core/services/dio_service.dart';
import '../models/add_new_preview_time_request_model.dart';

abstract class BasePreviewPropertyDataSource {
  Future<List<DayAndHoursModel>> getPropertyPreviewAvailableHours(String propertyId);
  Future<String> getInspectionAmountToBePaid(String propertyId);
  Future<void> addNewPreviewTime (AddNewPreviewRequestModel data);

}

class PreviewPropertyRemoteDataSource extends BasePreviewPropertyDataSource {
  DioService dioService;

  PreviewPropertyRemoteDataSource({required this.dioService});



  @override
  Future<List<DayAndHoursModel>> getPropertyPreviewAvailableHours(String propertyId)async {
    final response = await dioService.get(
      url: '${ApiConstants.propertyBusyDays}/$propertyId/' ,
    );


   /* List<dynamic> jsonResponse = response.data;

    List<DayAndHoursModel> availableHours = jsonResponse.map((day) {
      return DayAndHoursModel.fromJson(day);
    }).toList();

    return availableHours ;*/


    Map<String, dynamic> jsonData = {
      "date": "2025-03-17",
      "busy_hours": ["08:00", "12:00", "15:00"]
    };

    List<DayAndHoursModel> availableHours = [];

    availableHours.add(DayAndHoursModel.fromJson(jsonData));

    return availableHours ;
  }

  @override
  Future<String> getInspectionAmountToBePaid(String propertyId)async {
    final response = await dioService.get(
      url: '${ApiConstants.propertyOrderDetails}/$propertyId/' ,
    );


    return response.data['viewing_request_amount'].toString() ;

   }

  @override
  Future<void> addNewPreviewTime(AddNewPreviewRequestModel data) async {
    FormData formData = FormData.fromMap(data.toJson());

    var res = await dioService.post(
      url: '${ApiConstants.preview}/',
      data: formData,
      options: Options(
        contentType: Headers.multipartFormDataContentType,
      ),
    );
  }

}