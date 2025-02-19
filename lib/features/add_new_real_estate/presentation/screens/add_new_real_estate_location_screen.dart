import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/custom_app_drop_down.dart';
import '../../../../core/components/custom_map.dart';

import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';
import '../components/select_amenities.dart';
import '../controller/add_new_real_estate_cubit.dart';

class AddNewRealEstateLocationScreen extends StatelessWidget {
    AddNewRealEstateLocationScreen({super.key});

  List<LatLng> _selectedPoints = [];

  @override
  Widget build(BuildContext context) {
    var addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: addNewRealEstateCubit.locationForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumberedTextHeaderComponent(
              number: '3',
              text: ' الموقع والمميزات',
            ),
            SizedBox(height: context.scale(20)),
            // Address form
            FormWidgetComponent(
              label: 'حدد الموقع ',
              content: Row(
                children: [
                  Expanded(
                    child: CustomDropdown<String>(
                      items: ['caaa', 'ssafsafas'],
                      onChanged: (value) {},
                      itemToString: (item) => item,
                      hint: Text(' المحافظة', style: TextStyle(fontSize: FontSize.s12)),
                      icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.whiteColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: ColorManager.whiteColor,
                      menuMaxHeight: 200,
                      style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Choose city
            FormWidgetComponent(
              label: 'اختر المحافظة والمدينة ',
              content: Row(
                children: [
                  Expanded(
                    child: CustomDropdown<String>(
                      items: ['caaa', 'ssafsafas'],
                      onChanged: (value) {},
                      itemToString: (item) => item,
                      hint: Text(' المحافظة', style: TextStyle(fontSize: FontSize.s12)),
                      icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.whiteColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: ColorManager.whiteColor,
                      menuMaxHeight: 200,
                      style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomDropdown<String>(
                      items: ['asdsa', 'ssafsafas'],
                      onChanged: (value) {},
                      itemToString: (item) => item,
                      hint: Text('المدينة', style: TextStyle(fontSize: FontSize.s12)),
                      icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.whiteColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: ColorManager.whiteColor,
                      menuMaxHeight: 200,
                      style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            FormWidgetComponent(
              label: 'حدد الموقع',
              content: Column(
                children: [
                  Container(
                    height: context.scale(180),
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
                    child: CustomMap(
                      points: _selectedPoints,
                    ),
                  ),
                ],
              ),
            ),


            FormWidgetComponent(
              label: 'الخدمات والمرافق القريبة',
              content: SelectAmenities(),
            ),


            // payment methods

            FormWidgetComponent(
              label: 'خيارات الدفع  ',
              content: Row(
                children: [
                  Expanded(
                    child: CustomDropdown<String>(
                      items: ['caaa', 'ssafsafas'],
                      onChanged: (value) {},
                      itemToString: (item) => item,
                      hint: Text(' ', style: TextStyle(fontSize: FontSize.s12)),
                      icon: Icon(Icons.keyboard_arrow_down, color: ColorManager.greyShade),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorManager.whiteColor,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      dropdownColor: ColorManager.whiteColor,
                      menuMaxHeight: 200,
                      style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}