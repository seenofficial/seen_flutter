import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';

class ImagePickingFailure {
  final String message;
  final dynamic exception;

  ImagePickingFailure(this.message, [this.exception]);

  @override
  String toString() => message;
}

abstract class ImagePickingService {
  Future<Either<ImagePickingFailure, List<XFile>>> pickImages({int maxImages = 5, int maxImageSizeInBytes = 5 * 1024 * 1024});
}

class DeviceImagePickingService implements ImagePickingService {
  final ImagePicker _picker;

  DeviceImagePickingService({ImagePicker? picker})
      : _picker = picker ?? ImagePicker();

  @override
  Future<Either<ImagePickingFailure, List<XFile>>> pickImages({int maxImages = 5,
    int maxImageSizeInBytes = 5 * 1024 * 1024}) async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(limit: maxImages);

      if (images.isEmpty) {
        return Right([]);
      }

      List<XFile> validImages = [];

      for (var image in images) {
        try {
          // Check file size
          final file = File(image.path);
          final fileSize = await file.length();

          if (fileSize > maxImageSizeInBytes) {
            print('Image ${image.path} exceeds the maximum size limit of 5 MB. Skipping.');
            continue;
          }

          try {
             await file.openRead(0, 4).first;
            validImages.add(image);
          } catch (e) {
            print('Failed to process image ${image.path} as-is. Attempting to convert to JPEG...');

            // Attempt to convert the image to JPEG
            final convertedFile = await convertToJpg(image);
            if (convertedFile != null) {
              validImages.add(XFile(convertedFile.path));
            } else {
              print('Failed to convert image ${image.path} to JPEG. Skipping.');
            }
          }
        } catch (e) {
          print('Failed to process image ${image.path}: $e');
        }
      }

      return Right(validImages);
    } catch (e) {
      return Left(ImagePickingFailure('Failed to pick images: $e', e));
    }
  }

  Future<File?> convertToJpg(XFile xFile) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        xFile.path,
        xFile.path + '_converted.png',
        format: CompressFormat.png ,
        quality: 85,
      );

      if (result != null) {
        return File(result.path);
      }
    } catch (e) {
      print('Failed to convert image to JPEG: $e');
    }
    return null;
  }
}


class ImagePickerHelper {
  final ImagePickingService _imagePickingService;

  ImagePickerHelper({ImagePickingService? imagePickingService})
      : _imagePickingService = imagePickingService ?? DeviceImagePickingService();

  Future<Either<ImagePickingFailure, List<XFile>>> pickImages({int maxImages = 5, int maxImageSizeInBytes = 5 * 1024 * 1024}) async {
    return await _imagePickingService.pickImages(maxImages: maxImages, maxImageSizeInBytes: maxImageSizeInBytes);
  }

  Future<List<File>> processImagesWithResiliency(List<XFile> xFiles) async {
    List<File> successfulFiles = [];

    for (var xFile in xFiles) {
      try {
        File file = File(xFile.path);

         if (await file.exists()) {
          try {
             await file.openRead(0, 4).first;
            successfulFiles.add(file);
          } catch (e) {
            print('File exists but cannot be read: ${file.path}');
          }
        } else {
          print('File does not exist: ${file.path}');
        }
      } catch (e) {
        print('Failed to process image ${xFile.path}: $e');
      }
    }

    print('Successfully processed ${successfulFiles.length} images');
    return successfulFiles;
  }
}