import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../../core/components/custom_map.dart';
import '../../../../home_module/home_imports.dart';



class RealEstateDetailsLocation extends StatelessWidget {
  const RealEstateDetailsLocation({super.key , required this.location});

  final LatLng location ;
  @override
  Widget build(BuildContext context) {
    return Column(

      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: context.scale(16)),
        Container(
          height: context.scale(205),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(12),
            border: Border.all(
              color: ColorManager.greyShade,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(
                    0.1),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomMap(
                    points: [
                  location
                ]),
              ),
            ],
          ),
        ),
      ],
    );

  }
}
