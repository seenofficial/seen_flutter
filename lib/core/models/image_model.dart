import 'package:enmaa/core/constants/json_keys.dart';
import 'package:enmaa/core/entites/image_entity.dart';

class ImageModel extends ImageEntity{
  const ImageModel({
    required super.id,
    required super.image,
    required super.isMain,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
     id: json[JsonKeys.id] ?? 0,
      image: json[JsonKeys.image] ?? '',
      isMain: json[JsonKeys.isMain] ?? true ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      JsonKeys.id: id,
      JsonKeys.image: image,
      JsonKeys.isMain: isMain,
    };
  }
}