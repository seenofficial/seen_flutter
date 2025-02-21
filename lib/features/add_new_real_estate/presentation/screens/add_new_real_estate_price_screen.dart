import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/operation_type_property_extension.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/controller/add_new_real_estate_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../../../core/utils/form_validator.dart';
import '../../../home_module/home_imports.dart';
import '../components/dashed_border_container.dart';
import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';
import '../components/reusable_type_selector_component.dart';
import '../components/select_images_component.dart';

class AddNewRealEstatePriceScreen extends StatefulWidget {
  const AddNewRealEstatePriceScreen({super.key});

  @override
  _AddNewRealEstatePriceScreenState createState() => _AddNewRealEstatePriceScreenState();
}

class _AddNewRealEstatePriceScreenState extends State<AddNewRealEstatePriceScreen> {





  @override
  Widget build(BuildContext context) {
    var addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: addNewRealEstateCubit.priceForm,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NumberedTextHeaderComponent(
              number: '2',
              text: 'السعر والوصف ',
            ),
            SizedBox(height: context.scale(20)),

            // Address form
            FormWidgetComponent(
              label: 'العنوان ',
              content: AppTextField(
                controller: addNewRealEstateCubit.addressController,
                height: 40,
                hintText: 'أدخل عنوانًا مختصرًا للعقار.',
                keyboardType: TextInputType.text,
                backgroundColor: Colors.white,
                borderRadius: 20,
                padding: EdgeInsets.zero,
                validator: (value) => FormValidator.validateRequired(value, fieldName: 'العنوان'),
              ),
            ),

            // Description form
            FormWidgetComponent(
              label: 'الوصف',
              content: AppTextField(
                controller: addNewRealEstateCubit.descriptionController,
                height: 90,
                hintText: 'أدخل وصفًا تفصيليًا للعقار ...',
                keyboardType: TextInputType.multiline,
                backgroundColor: Colors.white,
                borderRadius: 20,
                padding: EdgeInsets.zero,
                maxLines: 3,
                validator: (value) => FormValidator.validateRequired(value, fieldName: 'الوصف'),
              ),
            ),

            BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(
              builder: (context, state) {
                var currentPropertyOperationType = state.currentPropertyOperationType;

                if (currentPropertyOperationType.isForSale) {
                  return FormWidgetComponent(
                    label: 'السعر',
                    content: AppTextField(
                      controller: addNewRealEstateCubit.priceController,
                      height: 40,
                      hintText: 'أدخل سعر العقار',
                      keyboardType: TextInputType.number,
                      backgroundColor: Colors.white,
                      borderRadius: 20,
                      padding: EdgeInsets.zero,
                      validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'السعر'),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormWidgetComponent(
                      label: 'الإيجار الشهري',
                      content: AppTextField(
                        controller: addNewRealEstateCubit.rentController,
                        height: 40,
                        hintText: '',
                        keyboardType: TextInputType.number,
                        backgroundColor: Colors.white,
                        borderRadius: 20,
                        padding: EdgeInsets.zero,
                        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'الإيجار الشهري'),
                      ),
                    ),
                    FormWidgetComponent(
                      label: 'مدة الإيجار بالشهور',
                      content: AppTextField(
                        controller: addNewRealEstateCubit.rentDurationController,
                        height: 40,
                        hintText: '',
                        keyboardType: TextInputType.number,
                        backgroundColor: Colors.white,
                        borderRadius: 20,
                        padding: EdgeInsets.zero,
                        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'مدة الإيجار بالشهور'),
                      ),
                    ),
                    FormWidgetComponent(
                      label: 'قابل للتجديد',
                      content: TypeSelectorComponent<String>(
                        selectorWidth: 171,
                        values: ['نعم', 'لا'],
                        currentType: state.availableForRenewal ? 'نعم' : 'لا',
                        onTap: (type) => addNewRealEstateCubit.changeAvailabilityForRenewal(),
                        getLabel: (type) => type == 'نعم' ? 'نعم' : 'لا',
                      ),
                    ),
                  ],
                );
              },
            ),

            SelectImagesComponent(),


          ],
        ),
      ),
    );
  }
}
