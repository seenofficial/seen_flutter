import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/my_profile/modules/contact_us_module/presenation/controller/contact_us_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';

import '../../../../../../configuration/managers/font_manager.dart';
import '../../../../../../core/components/app_bar_component.dart';
import '../../../../../../core/components/app_text_field.dart';
import '../../../../../../core/components/button_app_component.dart';
import '../../../../../../core/components/country_code_picker.dart';
import '../../../../../../core/components/custom_snack_bar.dart';
import '../../../../../../core/components/warning_message_component.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/form_validator.dart';
import '../../../../../home_module/home_imports.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with values from the ContactUsCubit state
    final contactUsCubit = context.read<ContactUsCubit>();
    nameController.text = contactUsCubit.state.name;
    phoneController.text = contactUsCubit.state.phoneNumber;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarComponent(
            appBarTextMessage: 'تواصل معنا',
            showNotificationIcon: false,
            showLocationIcon: false,
            centerText: true,
            showBackIcon: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Field
                      Text(
                        'الاسم',
                        style: getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: context.scale(8),
                      ),
                      AppTextField(
                        hintText: 'قم بادخال اسمك',
                        keyboardType: TextInputType.text,
                        borderRadius: 20,
                        padding: EdgeInsets.zero,
                        controller: nameController,
                        validator: (value) => FormValidator.validateRequired(value, fieldName: 'الاسم'),
                        onChanged: (value) {
                          context.read<ContactUsCubit>().changeName(value);
                        },
                      ),
                      SizedBox(
                        height: context.scale(16),
                      ),

                      Text(
                        'رقم الهاتف',
                        style: getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: context.scale(8),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<ContactUsCubit, ContactUsState>(
                            buildWhen: (previous, current) =>
                            previous.currentCountryCode != current.currentCountryCode,
                            builder: (context, state) {
                              return Expanded(
                                child: AppTextField(
                                  textDirection: TextDirection.ltr,
                                  hintText: '0100000000000',
                                  keyboardType: TextInputType.phone,
                                  borderRadius: 20,
                                  padding: EdgeInsets.zero,
                                  controller: phoneController,
                                  validator: (value) => FormValidator.validateRequired(value, fieldName: 'رقم الهاتف'),
                                  onChanged: (value) {
                                    context.read<ContactUsCubit>().changePhoneNumber(value);
                                    if (!value.startsWith(state.currentCountryCode)) {
                                      phoneController.clear();
                                      phoneController.text = state.currentCountryCode;
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(width: context.scale(8)),
                          Container(
                              width: context.scale(88),
                              height: context.scale(44),
                              decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomCountryCodePicker(
                                onChanged: (CountryCode countryCode) {
                                  phoneController.clear();
                                  phoneController.text = countryCode.dialCode!;
                                  context.read<ContactUsCubit>().setCountryCode(countryCode.dialCode!);
                                },
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.scale(16),
                      ),

                      Text(
                        'كيف يمكننا مساعدتك',
                        style: getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: context.scale(8),
                      ),
                      AppTextField(
                        controller: messageController,
                        height: 113,
                        hintText: 'أدخل رسالتك هنا...',
                        keyboardType: TextInputType.multiline,
                        backgroundColor: Colors.white,
                        borderRadius: 20,
                        padding: EdgeInsets.zero,
                        maxLines: 4,
                        validator: (value) => FormValidator.validateRequired(value, fieldName: 'الرسالة'),
                        onChanged: (value) {
                          context.read<ContactUsCubit>().changeMessage(value);
                        },
                      ),
                      SizedBox(
                        height: context.scale(16),
                      ),
                      WarningMessageComponent(
                        text: 'يرجى كتابة استفسارك وسنقوم بالرد عليك في أقرب وقت ممكن',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: EdgeInsets.only(
              bottom: context.scale(25),
              left: context.scale(16),
              right: context.scale(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonAppComponent(
                  width: 171,
                  height: 46,
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: ColorManager.grey3,
                    borderRadius: BorderRadius.circular(context.scale(24)),
                  ),
                  buttonContent: Center(
                    child: Text(
                      'إلغاء',
                      style: getMediumStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),

                BlocConsumer<ContactUsCubit, ContactUsState>(
                  listenWhen: (previous, current) =>
                  previous.contactUsRequestState != current.contactUsRequestState,
                  listener: (context, state) {
                    if (state.contactUsRequestState == RequestState.loaded) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'تم إرسال رسالتك بنجاح',
                        type: SnackBarType.success,
                      );
                      Navigator.pop(context);
                    } else if (state.contactUsRequestState == RequestState.error) {
                      CustomSnackBar.show(
                        context: context,
                        message: state.contactUsErrorMessage,
                        type: SnackBarType.error,
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                  previous.contactUsRequestState != current.contactUsRequestState,
                  builder: (context, state) {


                    return ButtonAppComponent(
                      width: 171,
                      height: 46,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: ColorManager.primaryColor,
                        borderRadius: BorderRadius.circular(context.scale(24)),
                      ),
                      buttonContent: Center(
                        child: state.contactUsRequestState == RequestState.loading
                            ? CupertinoActivityIndicator(color: ColorManager.whiteColor)
                            : Text(
                          'إرسال',
                          style: getBoldStyle(
                            color: ColorManager.whiteColor,
                            fontSize: FontSize.s12,
                          ),
                        ),
                      ),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ContactUsCubit>().sendContactUsRequest();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}