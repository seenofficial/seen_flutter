import 'package:animate_do/animate_do.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/buyer_type_extension.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/managers/value_manager.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/components/country_code_picker.dart';
import '../../../../core/components/custom_date_picker.dart';
import '../../../../core/components/reusable_type_selector_component.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../add_new_real_estate/presentation/components/numbered_text_header_component.dart';
import '../../../add_new_real_estate/presentation/components/select_images_component.dart';
import '../../../home_module/home_imports.dart';
import '../controller/book_property_cubit.dart';

class BuyerDataScreen extends StatefulWidget {
  const BuyerDataScreen({super.key});

  @override
  State<BuyerDataScreen> createState() => _BuyerDataScreenState();
}

class _BuyerDataScreenState extends State<BuyerDataScreen> {
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الموبايل مطلوب';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الاسم مطلوب';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const NumberedTextHeaderComponent(
              number: '٢',
              text: ' بيانات المُشتري',
            ),
            SizedBox(height: context.scale(20)),
            BlocBuilder<BookPropertyCubit, BookPropertyState>(
              builder: (context, state) {
                return TypeSelectorComponent<BuyerType>(
                  selectorWidth: 171,
                  values: BuyerType.values,
                  currentType: state.buyerType,
                  onTap: (type) {
                    context.read<BookPropertyCubit>().changeBuyerType(type);
                  },
                  getIcon: (type) {
                    switch (type) {
                      case BuyerType.iAmBuyer:
                        return AppAssets.emptyIcon;
                      case BuyerType.anotherBuyer:
                        return AppAssets.emptyIcon;
                    }
                  },
                  getLabel: (type) => type.toName,
                );
              },
            ),
            SizedBox(height: context.scale(20)),
            Text(
              'صورة الهوية',
              style: getBoldStyle(
                  color: ColorManager.blackColor, fontSize: FontSize.s16),
            ),
            SizedBox(height: context.scale(8)),
            BlocBuilder<BookPropertyCubit, BookPropertyState>(
              builder: (context, state) {
                final cubit = context.read<BookPropertyCubit>();
                return SelectImagesComponent(
                  height: 124,
                  selectedImages: state.selectedImages,
                  isLoading: state.selectImagesState.isLoading,
                  validateImages: state.validateImages,
                  hintText: 'يرجى رفع صور واضحة لهويتك لضمان التحقق السريع.',
                  onSelectImages: () async {
                    cubit.selectImage(1);
                  },
                  onRemoveImage: cubit.removeImage,
                  onValidateImages: cubit.validateImages,
                  mode: ImageSelectionMode.single,
                );
              },
            ),
            SizedBox(height: context.scale(16)),

            Text(
              'رقم الموبايل',
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s12,
              ),
            ),
            SizedBox(height: context.scale(16)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<BookPropertyCubit, BookPropertyState>(
                  buildWhen: (previous, current) =>
                  previous.countryCode != current.countryCode ||
                      previous.phoneNumberController.text != current.phoneNumberController.text,
                  builder: (context, state) {
                    return Expanded(
                      child: AppTextField(
                        textDirection: TextDirection.ltr,
                        hintText: '0100000000000',
                        keyboardType: TextInputType.phone,
                        borderRadius: 20,
                        backgroundColor: ColorManager.whiteColor,
                        padding: EdgeInsets.zero,
                        controller: state.phoneNumberController,
                        validator: _validatePhone,
                        onChanged: (value) {
                          if (!value.startsWith(state.countryCode)) {
                            state.phoneNumberController.clear();
                            state.phoneNumberController.text = state.countryCode;
                          }
                          context.read<BookPropertyCubit>().setPhoneNumber(value);
                        },
                      ),
                    );
                  },
                ),
                SizedBox(width: context.scale(8)),

                BlocBuilder<BookPropertyCubit, BookPropertyState>(
                  builder: (context, state) {
                    return Container(
                        width: context.scale(88),
                        height: context.scale(44),
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomCountryCodePicker(
                          onChanged: (CountryCode countryCode) {
                            state.phoneNumberController.clear();
                            state.phoneNumberController.text = countryCode.dialCode!;
                            BlocProvider.of<BookPropertyCubit>(context)
                                .setCountryCode(countryCode.dialCode!);
                          },
                        )
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: context.scale(16)),
            Text(
              'الاسم الكامل',
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s12,
              ),
            ),
            SizedBox(height: context.scale(8)),
            BlocBuilder<BookPropertyCubit, BookPropertyState>(
              buildWhen: (previous, current) =>
              previous.nameController.text != current.nameController.text,
              builder: (context, state) {
                return AppTextField(
                  hintText: 'اسم المشتري',
                  keyboardType: TextInputType.name,
                  borderRadius: 20,
                  backgroundColor: ColorManager.whiteColor,
                  padding: EdgeInsets.zero,
                  controller: state.nameController,
                  validator: _validateName,
                  onChanged: (value) {
                    // You need to add setUserName method to your BookPropertyCubit
                    context.read<BookPropertyCubit>().setUserName(value);
                  },
                );
              },
            ),
            SizedBox(height: context.scale(16)),

            Text(
              'رقم الهويه',
              style: getBoldStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s12,
              ),
            ),
            SizedBox(height: context.scale(8)),
            BlocBuilder<BookPropertyCubit, BookPropertyState>(
              buildWhen: (previous, current) =>
              previous.iDNumberController.text != current.iDNumberController.text,
              builder: (context, state) {
                return AppTextField(
                  hintText: '12345678901234',
                  keyboardType: TextInputType.number,
                  borderRadius: 20,
                  backgroundColor: ColorManager.whiteColor,
                  padding: EdgeInsets.zero,
                  controller: state.iDNumberController,
                  validator: _validateName,
                  onChanged: (value) {
                    context.read<BookPropertyCubit>().setIDUserNumber(value);
                  },
                );
              },
            ),

            SizedBox(height: context.scale(16)),



            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  // Birth Date Picker
                  Expanded(
                    child: BlocBuilder<BookPropertyCubit, BookPropertyState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تاريخ الميلاد',
                              style: getBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            SizedBox(height: context.scale(8)),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return Dialog(

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(context.scale(12)),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(context.scale(16)),
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        height: MediaQuery.of(context).size.height * 0.4,
                                        decoration: BoxDecoration(
                                          color: ColorManager.whiteColor,
                                          borderRadius: BorderRadius.circular(context.scale(12)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorManager.blackColor.withOpacity(0.1),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: CustomDatePicker(
                                          showPreviousDates: true,
                                          selectedDate: state.birthDate,
                                          onSelectionChanged: (calendarSelectionDetails) {
                                            context.read<BookPropertyCubit>().selectBirthDate(
                                              calendarSelectionDetails.date!,
                                            );
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: context.scale(44),
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  borderRadius: BorderRadius.circular(context.scale(20)),
                                  border: Border.all(
                                    color: ColorManager.greyShade,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                                  child: Row(
                                    children: [
                                      SvgImageComponent(
                                        iconPath: AppAssets.calendarIcon,
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(width: context.scale(8)),
                                      Expanded(
                                        child: Text(
                                          state.birthDate != null
                                              ? '${state.birthDate!.day}/${state.birthDate!.month}/${state.birthDate!.year}'
                                              : 'اختر التاريخ',
                                          style: state.birthDate == null
                                              ? getRegularStyle(
                                            color: ColorManager.grey2,
                                            fontSize: FontSize.s12,
                                          )
                                              : getSemiBoldStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: FontSize.s12,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: ColorManager.grey2,
                                        size: context.scale(24),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  SizedBox(width: context.scale(16)),

                  // ID Expiration Date Picker
                  Expanded(
                    child: BlocBuilder<BookPropertyCubit, BookPropertyState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'تاريخ انتهاء البطاقة',
                              style: getBoldStyle(
                                color: ColorManager.blackColor,
                                fontSize: FontSize.s12,
                              ),
                            ),
                            SizedBox(height: context.scale(8)),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext dialogContext) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(context.scale(12)),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(context.scale(16)),
                                        width: MediaQuery.of(context).size.width * 0.8,
                                        height: MediaQuery.of(context).size.height * 0.4,                                        decoration: BoxDecoration(
                                          color: ColorManager.whiteColor,
                                          borderRadius: BorderRadius.circular(context.scale(12)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorManager.blackColor.withOpacity(0.1),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: CustomDatePicker(
                                          showPreviousDates: true,
                                          selectedDate: state.idExpirationDate,
                                          onSelectionChanged: (calendarSelectionDetails) {
                                            context.read<BookPropertyCubit>().selectIDExpirationDate(
                                              calendarSelectionDetails.date!,
                                            );
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: context.scale(44),
                                decoration: BoxDecoration(
                                  color: ColorManager.whiteColor,
                                  borderRadius: BorderRadius.circular(context.scale(20)),
                                  border: Border.all(
                                    color: ColorManager.greyShade,
                                    width: 0.5,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                                  child: Row(
                                    children: [
                                      SvgImageComponent(
                                        iconPath: AppAssets.calendarIcon,
                                        width: 16,
                                        height: 16,
                                      ),
                                      SizedBox(width: context.scale(8)),
                                      Expanded(
                                        child: Text(
                                          state.idExpirationDate != null
                                              ? '${state.idExpirationDate!.day}/${state.idExpirationDate!.month}/${state.idExpirationDate!.year}'
                                              : 'اختر التاريخ',
                                          style: state.idExpirationDate == null
                                              ? getRegularStyle(
                                            color: ColorManager.grey2,
                                            fontSize: FontSize.s12,
                                          )
                                              : getSemiBoldStyle(
                                            color: ColorManager.primaryColor,
                                            fontSize: FontSize.s12,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: ColorManager.grey2,
                                        size: context.scale(24),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )

          ],
        ));
  }
}