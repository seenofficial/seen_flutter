import 'package:dio/dio.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/property_request_model.dart';
import '../../../../core/constants/json_keys.dart';

class LandRequestModel extends PropertyRequestModel {
  final String area;
  final bool isLicensed;

  LandRequestModel({
    // Common fields from PropertyRequestModel
    required super.currentPropertyOperationType,
    required super.title,
    required super.description,
    required super.price,
    required super.images,
    required super.country,
    required super.state,
    required super.city,
    required super.latitude,
    required super.longitude,
    required super.amenities,
    required super.propertySubType,
    super.monthlyRentPeriod,
    super.isRenewable,
    super.paymentMethod,
    // Land-specific fields:
    required this.area,
    required this.isLicensed,
  });

  @override
  Future<FormData> toFormData() async {
    final formData = await super.toFormData();

    formData.fields.addAll([
      MapEntry(JsonKeys.area, area),
      MapEntry(JsonKeys.isLicensed, isLicensed.toString()),
    ]);

    return formData;
  }
}
