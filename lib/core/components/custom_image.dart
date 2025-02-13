
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

import '../../configuration/managers/color_manager.dart';
import '../../features/home_module/home_imports.dart';


class CustomNetworkImage extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool? border;
  final bool isProduct;
  final BorderRadiusGeometry? borderRadiusGeometry;

  const CustomNetworkImage({
    super.key,
    this.image,
    this.height,
    this.border = false,
    this.width,
    this.fit = BoxFit.fill,
    this.isProduct = false,
    this.borderRadiusGeometry,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image!,
      height: height,
      width: width,
      fit: fit,
        errorWidget : (context, url, error) => Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: ColorManager.greyShade,
            borderRadius: borderRadiusGeometry,
          ),
          child: const Center(child: Icon(Icons.error)),
        ),
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: ColorManager.primaryColor.withOpacity(.1),
          child: Container(
            height: height,
            width: width,
            color: isProduct ? null : ColorManager.primaryColor.withOpacity(.1),
            decoration: isProduct
                ? BoxDecoration(
                color: ColorManager.greyShade,
                borderRadius: borderRadiusGeometry)
                : null,
              child: const Center(child: CupertinoActivityIndicator()),
          ),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          color: isProduct ? null : ColorManager.greyShade,
          borderRadius: borderRadiusGeometry,
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
    );
  }
}