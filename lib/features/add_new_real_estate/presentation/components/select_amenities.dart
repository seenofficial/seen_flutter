import 'package:flutter/material.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/selected_item_text_style.dart';

class SelectAmenities extends StatefulWidget {
  const SelectAmenities({super.key});

  @override
  _SelectAmenitiesState createState() => _SelectAmenitiesState();
}

class _SelectAmenitiesState extends State<SelectAmenities> {
  final List<String> items = ["تكييف", "حمام سباحة", "ساونا", "جيم"];
  final Set<int> selectedIndexes = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 4,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final isSelected = selectedIndexes.contains(index);

            return ButtonAppComponent(
              width: 173,
              height: 40,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(context.scale(20)),
                border: Border.all(
                  color: isSelected ? ColorManager.primaryColor : Colors.transparent,
                  width: 1,
                ),
              ),
              buttonContent: Padding(
                padding:  EdgeInsets.symmetric(horizontal: context.scale(12) , vertical: context.scale(8)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: context.scale(16),
                      height: context.scale(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? ColorManager.primaryColor : ColorManager.grey3,
                      ),
                      child: isSelected
                          ? Icon(Icons.check, color: ColorManager.whiteColor, size: context.scale(15))
                          : null,
                    ),
                    SizedBox(width: context.scale(8)),
                    Text(items[index], style: currentTextStyle(isSelected)),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  isSelected ? selectedIndexes.remove(index) : selectedIndexes.add(index);
                });
              },
            );
          },
        ),
      ],
    );
  }
}
