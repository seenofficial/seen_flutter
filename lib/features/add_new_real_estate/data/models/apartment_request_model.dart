import 'package:dio/dio.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/property_request_model.dart';
import '../../../../core/constants/json_keys.dart';

class ApartmentRequestModel extends PropertyRequestModel {
  final String area;
  final String usageType;
  final String status;
  final int apartmentType;
  final bool isFurnitured;
  final String floor;
  final String rooms;
  final String bathrooms;
  final int yearBuilt;

  ApartmentRequestModel({
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
    //
    required this.area,
    required this.usageType,
    required this.status,
    required this.apartmentType,
    required this.isFurnitured,
    required this.floor,
    required this.rooms,
    required this.bathrooms,
    required this.yearBuilt,
  });

  @override
  Future<FormData> toFormData() async {
    final formData = await super.toFormData();

    formData.fields.addAll([
      MapEntry(JsonKeys.area, area),
      MapEntry(JsonKeys.usageType, usageType),
      MapEntry(JsonKeys.status, status),
      MapEntry(JsonKeys.propertySubType, apartmentType.toString()),
      MapEntry(JsonKeys.isFurnitured, isFurnitured.toString()),
      MapEntry(JsonKeys.floor, floor),
      MapEntry(JsonKeys.rooms, rooms),
      MapEntry(JsonKeys.bathrooms, bathrooms),
      MapEntry(JsonKeys.yearBuilt, yearBuilt.toString()),
    ]);

    return formData;
  }
}
