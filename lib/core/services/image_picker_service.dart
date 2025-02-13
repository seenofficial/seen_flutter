import 'package:image_picker/image_picker.dart';

abstract class ImagePickingService {
  Future<List<XFile>> pickImages({int maxImages = 5});
}

class DeviceImagePickingService implements ImagePickingService {
  final ImagePicker _picker;

  DeviceImagePickingService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  @override
  Future<List<XFile>> pickImages({int maxImages = 5}) async {
    try {
      // Allow the user to pick multiple images
      final List<XFile> images = await _picker.pickMultiImage(limit: maxImages);

      // Check if the number of selected images exceeds the limit
      if (images.length > maxImages) {
        throw ImagePickingException('You can select a maximum of $maxImages images.');
      }

      return images;
    } catch (e) {
      throw ImagePickingException('Failed to pick images: ${e.toString()}');
    }
  }
}

class ImagePickingException implements Exception {
  final String message;

  ImagePickingException(this.message);

  @override
  String toString() => message;
}

class ImagePickerHelper {
  final ImagePickingService _imagePickingService;

  ImagePickerHelper({ImagePickingService? imagePickingService})
      : _imagePickingService = imagePickingService ?? DeviceImagePickingService();

  Future<List<XFile>> pickImages({int maxImages = 5}) async {
    try {
      return await _imagePickingService.pickImages(maxImages: maxImages);
    } catch (e) {
      rethrow;
    }
  }
}