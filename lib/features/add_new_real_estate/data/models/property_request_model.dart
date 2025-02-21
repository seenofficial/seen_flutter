import 'package:dio/dio.dart';
import '../../../../core/constants/json_keys.dart';

abstract class PropertyRequestModel {
  final String currentPropertyOperationType;
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

  PropertyRequestModel({
    required this.currentPropertyOperationType,
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
    };

    // Add any additional fields from subclasses by overriding this method (via super)
    // if needed.

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
