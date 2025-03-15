import 'dart:io';
import 'package:dio/dio.dart';

class BookPropertyRequestModel {
  final String propertyId;
  final bool isUser;
  final String name;
  final String phoneNumber;
  final String idNumber;
  final String dateOfBirth;
  final String idExpiryDate;
  final String paymentMethod;
  final File idImage;

  BookPropertyRequestModel({
    required this.propertyId,
    required this.isUser,
    required this.name,
    required this.phoneNumber,
    required this.idNumber,
    required this.dateOfBirth,
    required this.idExpiryDate,
    required this.paymentMethod,
    required this.idImage,
  });

  Future<FormData> toFormData() async {

    return FormData.fromMap({
      'property_id': propertyId,
      'is_user': isUser ? 'True' : 'False',
      'name': name,
      'phone_number': phoneNumber,
      'id_number': idNumber,
      'date_of_birth': dateOfBirth,
      'id_expiry_date': idExpiryDate,
      'payment_method': paymentMethod,
      'id_image': await MultipartFile.fromFile(
        idImage.path,
        filename: idImage.path.split('/').last,
      ),
    });
  }
}
