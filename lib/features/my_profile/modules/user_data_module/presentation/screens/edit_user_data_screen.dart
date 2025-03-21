import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/my_profile/modules/user_data_module/presentation/controller/user_data_cubit.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/app_bar_component.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:enmaa/core/components/custom_date_picker.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';

import '../../../../../../core/constants/local_keys.dart';
import '../../../../../../core/services/shared_preferences_service.dart';
import '../../../../../../core/utils/enums.dart';
import '../components/user_data_screen_buttons.dart';

class EditUserDataScreen extends StatefulWidget {
  const EditUserDataScreen({super.key});

  @override
  State<EditUserDataScreen> createState() => _EditUserDataScreenState();
}

class _EditUserDataScreenState extends State<EditUserDataScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _idNumberController;
  DateTime? _selectedBirthDate;
  DateTime? _selectedIdExpirationDate;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _idNumberController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sharedPrefs = SharedPreferencesService();
      if (!sharedPrefs.hasKey(LocalKeys.userPhone)) {
        context.read<UserDataCubit>().getRemoteUserData();
      } else {
        context.read<UserDataCubit>().getLocalUserData();
      }
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  void _onSavePressed() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        'full_name': _fullNameController.text,
        'phone_number': _phoneNumberController.text,
        'id_number': _idNumberController.text,
        'date_of_birth': _selectedBirthDate != null
            ? '${_selectedBirthDate!.day}/${_selectedBirthDate!.month}/${_selectedBirthDate!.year}'
            : '',
        'id_expiry_date': _selectedIdExpirationDate != null
            ? '${_selectedIdExpirationDate!.day}/${_selectedIdExpirationDate!.month}/${_selectedIdExpirationDate!.year}'
            : '',
      };
      context.read<UserDataCubit>().updateUserData(updatedData);
    }
  }

  void _spreadUserData(UserDataState state) {
    if (state.getUserDataState == RequestState.loaded && state.userDataEntity != null) {
       _fullNameController.text = state.userDataEntity!.userName ?? '';
      _phoneNumberController.text = state.userDataEntity!.phoneNumber ?? '';
      _idNumberController.text = state.userDataEntity!.idNumber ?? '';
      _selectedBirthDate = _parseDate(state.userDataEntity!.dateOfBirth);
      _selectedIdExpirationDate = _parseDate(state.userDataEntity!.idExpirationDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarComponent(
            appBarTextMessage: 'الصفحة الشخصية',
            showNotificationIcon: false,
            showLocationIcon: false,
            centerText: true,
            showBackIcon: true,
          ),
          Expanded(
            child: BlocListener<UserDataCubit, UserDataState>(
              listener: (context, state) {

                _spreadUserData(state);
              },
              child: BlocBuilder<UserDataCubit, UserDataState>(
                builder: (context, state) {
                  if (state.getUserDataState.isLoading || state.getUserDataState.isInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.getUserDataState.isLoaded) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(context.scale(16)),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: context.scale(60),
                                        height: context.scale(60),
                                        decoration: BoxDecoration(
                                          color: ColorManager.primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            _fullNameController.text.isNotEmpty
                                                ? _fullNameController.text[0]
                                                : 'U',
                                            style: getBoldStyle(
                                              color: ColorManager.whiteColor,
                                              fontSize: FontSize.s18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.scale(16)),
                                  Text('الاسم الكامل',
                                      style: getBoldStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: FontSize.s16)),
                                  SizedBox(height: context.scale(8)),
                                  AppTextField(
                                    controller: _fullNameController,
                                    height: 40,
                                    hintText: 'أدخل الاسم الكامل',
                                    backgroundColor: Colors.white,
                                    borderRadius: 24,
                                    validator: (value) =>
                                    value == null || value.isEmpty ? 'الرجاء إدخال الاسم الكامل' : null,
                                    padding: EdgeInsets.zero,
                                  ),
                                  SizedBox(height: context.scale(16)),
                                  Text('رقم الهاتف',
                                      style: getBoldStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: FontSize.s16)),
                                  SizedBox(height: context.scale(8)),
                                  AppTextField(
                                    controller: _phoneNumberController,
                                    height: 40,
                                    hintText: 'أدخل رقم الهاتف',
                                    backgroundColor: Colors.white,
                                    borderRadius: 24,
                                    editable: false,
                                    validator: (value) =>
                                    value == null || value.isEmpty ? 'الرجاء إدخال رقم الهاتف' : null,
                                    padding: EdgeInsets.zero,
                                  ),
                                  SizedBox(height: context.scale(16)),
                                  Text('رقم الهوية',
                                      style: getBoldStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: FontSize.s16)),
                                  SizedBox(height: context.scale(8)),
                                  AppTextField(
                                    controller: _idNumberController,
                                    height: 40,
                                    hintText: 'أدخل رقم الهوية',
                                    backgroundColor: Colors.white,
                                    borderRadius: 24,
                                    validator: (value) =>
                                    value == null || value.isEmpty ? 'الرجاء إدخال رقم الهوية' : null,
                                    padding: EdgeInsets.zero,
                                  ),
                                  SizedBox(height: context.scale(16)),
                                  Text('تاريخ الميلاد',
                                      style: getBoldStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: FontSize.s16)),
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
                                                selectedDate: _selectedBirthDate,
                                                onSelectionChanged: (calendarSelectionDetails) {
                                                  setState(() {
                                                    _selectedBirthDate = calendarSelectionDetails.date!;
                                                  });
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
                                                _selectedBirthDate != null
                                                    ? '${_selectedBirthDate!.day}/${_selectedBirthDate!.month}/${_selectedBirthDate!.year}'
                                                    : 'اختر التاريخ',
                                                style: _selectedBirthDate == null
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
                                  SizedBox(height: context.scale(16)),
                                  Text('تاريخ انتهاء الهوية',
                                      style: getBoldStyle(
                                          color: ColorManager.blackColor,
                                          fontSize: FontSize.s16)),
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
                                                selectedDate: _selectedIdExpirationDate,
                                                onSelectionChanged: (calendarSelectionDetails) {
                                                  setState(() {
                                                    _selectedIdExpirationDate = calendarSelectionDetails.date!;
                                                  });
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
                                                _selectedIdExpirationDate != null
                                                    ? '${_selectedIdExpirationDate!.day}/${_selectedIdExpirationDate!.month}/${_selectedIdExpirationDate!.year}'
                                                    : 'اختر التاريخ',
                                                style: _selectedIdExpirationDate == null
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
                              ),
                            ),
                          ),
                        ),
                        UserDataScreenButtons(
                          onSavePressed: _onSavePressed,
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: Text(
                       'حدث خطأ أثناء جلب البيانات',
                      style: getBoldStyle(color: ColorManager.redColor, fontSize: FontSize.s16),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime? _parseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      final parts = dateString.split('/');
      if (parts.length != 3) return null;
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    } catch (e) {
      return null;
    }
  }
}