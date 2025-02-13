import 'package:enmaa/core/components/custom_image.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../domain/entities/app_service_entity.dart';
import '../../home_imports.dart';

class ServiceComponent extends StatelessWidget {
  const ServiceComponent({super.key, required this.category , required this.onTap});

  final AppServiceEntity category;
  final Function() onTap ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(context.scale(16)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.scale(10)),
            child: ClipOval(
              child: Container(
                width: context.scale(64),
                height: context.scale(64),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomNetworkImage(
                    image: category.image,
                    fit: BoxFit.cover,
                    width: context.scale(64),
                    height: context.scale(64),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: context.scale(8)),
          Text(
            category.text,
            style: getBoldStyle(color: ColorManager.blackColor),
          ),
        ],
      ),
    );
  }
}
