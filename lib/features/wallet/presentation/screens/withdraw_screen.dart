import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:enmaa/core/services/select_location_service/select_location_DI.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/components/app_bar_component.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:enmaa/core/components/button_app_component.dart';
import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/core/utils/form_validator.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import 'package:enmaa/features/wallet/data/models/withdraw_request_model.dart';
import 'package:enmaa/features/wallet/presentation/controller/wallet_cubit.dart';
import '../../../../configuration/managers/drop_down_style_manager.dart';
import '../../../../core/components/custom_app_drop_down.dart';
import '../../../add_new_real_estate/presentation/components/country_selector_component.dart';
import '../../../home_module/home_imports.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key, required this.walletCubit});

  final WalletCubit walletCubit;

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ibanController.dispose();
    _bankController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: widget.walletCubit,
        ),
        BlocProvider(
          create: (context) {
            return SelectLocationServiceCubit.getOrCreate()
              ..removeSelectedData()
              ..getCountries();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: ColorManager.greyShade,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarComponent(
              appBarTextMessage: LocaleKeys.withdrawTitle.tr(),
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
                        Text(
                          LocaleKeys.withdrawNameLabel.tr(),
                          style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s16),
                        ),
                        SizedBox(height: context.scale(8)),
                        AppTextField(
                          controller: _nameController,
                          hintText: LocaleKeys.withdrawNameHint.tr(),
                          keyboardType: TextInputType.text,
                          borderRadius: 20,
                          padding: EdgeInsets.zero,
                          validator: (value) =>
                              FormValidator.validateRequired(
                            value,
                            fieldName: LocaleKeys.withdrawNameLabel.tr(),
                          ),
                        ),
                        SizedBox(height: context.scale(16)),

                        Text(
                          LocaleKeys.withdrawIbanLabel.tr(),
                          style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s16),
                        ),
                        SizedBox(height: context.scale(8)),
                        AppTextField(
                          controller: _ibanController,
                          hintText: LocaleKeys.withdrawIbanHint.tr(),
                          keyboardType: TextInputType.text,
                          borderRadius: 20,
                          padding: EdgeInsets.zero,
                          validator: (value) =>
                              FormValidator.validateRequired(
                            value,
                            fieldName: LocaleKeys.withdrawIbanLabel.tr(),
                          ),
                        ),
                        SizedBox(height: context.scale(16)),

                        Text(
                          LocaleKeys.withdrawBankLabel.tr(),
                          style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s16),
                        ),
                        SizedBox(height: context.scale(8)),
                        AppTextField(
                          controller: _bankController,
                          hintText: LocaleKeys.withdrawBankHint.tr(),
                          keyboardType: TextInputType.text,
                          borderRadius: 20,
                          padding: EdgeInsets.zero,
                          validator: (value) =>
                              FormValidator.validateRequired(
                            value,
                            fieldName: LocaleKeys.withdrawBankLabel.tr(),
                          ),
                        ),
                        SizedBox(height: context.scale(16)),

                        Text(
                          LocaleKeys.country.tr(),
                          style: getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s16),
                        ),
                        SizedBox(height: context.scale(8)),
                        BlocBuilder<SelectLocationServiceCubit,
                            SelectLocationServiceState>(
                          buildWhen: (previous, current) =>
                              previous.getCountriesState !=
                                  current.getCountriesState ||
                              previous.selectedCountry !=
                                  current.selectedCountry,
                          builder: (context, state) {
                            return CustomDropdown<String>(
                              items:
                                  state.countries.map((e) => e.name).toList(),
                              value: state.selectedCountry?.name,
                              onChanged: (value) {
                                context
                                    .read<SelectLocationServiceCubit>()
                                    .changeSelectedCountry(value!);
                              },
                              itemToString: (item) => item,
                              hint: Text(LocaleKeys.selectCountryHint.tr(),
                                  style: TextStyle(fontSize: FontSize.s12)),
                              icon: Icon(Icons.keyboard_arrow_down,
                                  color: ColorManager.greyShade),
                              decoration:
                                  DropdownStyles.getDropdownDecoration(),
                              dropdownColor: ColorManager.whiteColor,
                              menuMaxHeight: 200,
                              style: getMediumStyle(
                                color: ColorManager.blackColor,
                                fontSize: FontSize.s14,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: context.scale(88),
              padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.scale(24)),
                  topRight: Radius.circular(context.scale(24)),
                ),
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
                        LocaleKeys.cancelButton.tr(),
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
                  BlocConsumer<WalletCubit, WalletState>(
                    listenWhen: (previous, current) =>
                        previous.withdrawRequestState !=
                        current.withdrawRequestState,
                    listener: (context, state) {
                      if (state.withdrawRequestState == RequestState.loaded) {
                        CustomSnackBar.show(
                          context: context,
                          message: LocaleKeys.withdrawSuccess.tr(),
                          type: SnackBarType.success,
                        );
                        Navigator.pop(context);
                      } else if (state.withdrawRequestState ==
                          RequestState.error) {
                        CustomSnackBar.show(
                          context: context,
                          message: state.withdrawRequestErrorMessage,
                          type: SnackBarType.error,
                        );
                      }
                    },
                    buildWhen: (previous, current) =>
                        previous.withdrawRequestState !=
                        current.withdrawRequestState,
                    builder: (context, state) {
                      return ButtonAppComponent(
                        width: 171,
                        height: 46,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius:
                              BorderRadius.circular(context.scale(24)),
                        ),
                        buttonContent: Center(
                          child: state.withdrawRequestState ==
                                  RequestState.loading
                              ? CupertinoActivityIndicator(
                                  color: ColorManager.whiteColor)
                              : Text(
                                  LocaleKeys.withdrawButton.tr(),
                                  style: getBoldStyle(
                                    color: ColorManager.whiteColor,
                                    fontSize: FontSize.s12,
                                  ),
                                ),
                        ),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final selectLocationState = context
                                .read<SelectLocationServiceCubit>()
                                .state;
                            if (selectLocationState.selectedCountry == null) {
                              CustomSnackBar.show(
                                context: context,
                                message: LocaleKeys.countryRequired.tr(),
                                type: SnackBarType.error,
                              );
                              return;
                            }
                            final withdrawModel = WithDrawRequestModel(
                              userName: _nameController.text.trim(),
                              IBANNumber: _ibanController.text.trim(),
                              bankName: _bankController.text.trim(),
                              country: selectLocationState.selectedCountry!.id
                                  .toString(),
                            );
                            context
                                .read<WalletCubit>()
                                .withdrawRequest(withdrawModel);
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
      ),
    );
  }
}
