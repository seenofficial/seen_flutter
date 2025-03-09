import 'package:dio/dio.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/property_request_model.dart';
import '../../../../core/constants/json_keys.dart';

class ApartmentRequestModel extends PropertyRequestModel {
  final String area;
  final bool isFurnitured;
  final String floor;
  final String rooms;
  final String bathrooms;

  ApartmentRequestModel({
    required super.currentPropertyOperationType,
    required super.title,
    required super.description,
    required super.price,
    required super.images,
    required super.city,
    required super.latitude,
    required super.longitude,
    required super.amenities,
    required super.propertySubType,
    required this.area,
    required this.isFurnitured,
    required this.floor,
    required this.rooms,
    required this.bathrooms,

    super.monthlyRentPeriod,
    super.isRenewable,
    super.paymentMethod,
  });

  @override
  Future<FormData> toFormData() async {
    final formData = await super.toFormData();

    formData.fields.addAll([
      MapEntry(JsonKeys.area, area),
      MapEntry(JsonKeys.propertySubType, propertySubType.toString()),
      MapEntry(JsonKeys.isFurnitured, isFurnitured.toString()),
      MapEntry(JsonKeys.floor, floor),
      MapEntry(JsonKeys.rooms, rooms),
      MapEntry(JsonKeys.bathrooms, bathrooms),
    ]);

    return formData;
  }
}
