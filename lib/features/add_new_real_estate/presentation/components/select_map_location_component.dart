import 'package:flutter/material.dart';
import 'package:enmaa/core/extensions/context_extension.dart';

import '../../../../../configuration/managers/color_manager.dart';
import '../../../../core/services/map_services/presentation/screens/base_map_screen.dart';
import 'form_widget_component.dart';

class MapLocationComponent extends StatelessWidget {

  const MapLocationComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormWidgetComponent(
      label: 'حدد الموقع',
      content: Column(
        children: [
          Container(
            height: context.scale(180),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorManager.greyShade,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: CustomMap(
              points: [],
            ),
          ),
        ],
      ),
    );
  }
}