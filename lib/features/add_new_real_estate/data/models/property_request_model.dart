import 'package:dio/dio.dart';
import '../../../../core/constants/json_keys.dart';

abstract class PropertyRequestModel {
  final String currentPropertyOperationType;
  final String propertySubType;
  final String title;
  final String description;
  final double price;
  final List<PropertyImage> images;
  final String country;
  final String state;
  final String city;
  final String latitude;
  final String longitude;
  final List<String> amenities;

  // Common fields for all properties
  final int? monthlyRentPeriod;
  final bool? isRenewable;
  final String? paymentMethod;

  PropertyRequestModel( {
    required this.currentPropertyOperationType,
    required this.propertySubType,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.country,
    required this.state,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.amenities,
    this.monthlyRentPeriod,
    this.isRenewable,
    this.paymentMethod,
  });

  /// Converts this model into a FormData object for a multipart/form-data request.
  Future<FormData> toFormData() async {
    // Create a base map for non-file fields.
    final Map<String, dynamic> data = {
      JsonKeys.operation: currentPropertyOperationType,
      JsonKeys.title: title,
      JsonKeys.description: description,
      JsonKeys.price: price,
      JsonKeys.country: country,
      JsonKeys.state: state,
      JsonKeys.city: city,
      JsonKeys.latitude: latitude,
      JsonKeys.longitude: longitude,
      JsonKeys.amenities: amenities,
      JsonKeys.propertySubType : propertySubType,
    };

    // Add common fields if they are not null
    if (monthlyRentPeriod != null) {
      data[JsonKeys.monthlyRentPeriod] = monthlyRentPeriod;
    }
    if (isRenewable != null) {
      data[JsonKeys.isRenewable] = isRenewable;
    }
    if (paymentMethod != null) {
      data[JsonKeys.paymentMethod] = paymentMethod;
    }

    // Start building FormData.
    final formData = FormData.fromMap(data);

    // Add image files.
    for (int i = 0; i < images.length; i++) {
      final filePath = images[i].filePath;
      final multipartFile = await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );
      // Add file under the key 'images'
      formData.files.add(MapEntry('images', multipartFile));
      // Add corresponding is_main flag for this image.
      formData.fields.add(
        MapEntry('images[$i].is_main', images[i].isMain?.toString() ?? 'false'),
      );
    }

    return formData;
  }
}

class PropertyImage {
  final String filePath;
  final bool? isMain;

  PropertyImage({required this.filePath, this.isMain});
}