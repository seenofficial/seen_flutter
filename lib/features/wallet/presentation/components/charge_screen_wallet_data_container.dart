import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/wallet/presentation/controller/wallet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/circular_icon_button.dart';
import '../../../../core/components/shimmer_component.dart';
import '../../../home_module/home_imports.dart';
import '../../domain/entities/wallet_data_entity.dart';

class ChargeScreenWalletDataContainer extends StatelessWidget {
  const ChargeScreenWalletDataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(368),
      decoration: BoxDecoration(
        color: ColorManager.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          if (state.getWalletDataState.isLoaded) {
            final WalletDataEntity walletData = state.walletDataEntity!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.scale(102),
                ),
                Text(
                  LocaleKeys.chargeScreenCurrentBalance.tr(),
                  style: getBoldStyle(
                      color: ColorManager.whiteColor, fontSize: FontSize.s16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      walletData.totalBalance.isEmpty
                          ? '0'
                          : walletData.totalBalance,
                      style: getBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s32),
                    ),
                    SizedBox(
                      width: context.scale(8),
                    ),
                    Text(
                      LocaleKeys.chargeScreenCurrency.tr(),
                      style: getBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.scale(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CircularIconButton(
                            containerSize: context.scale(60),
                            iconPath: AppAssets.chargeWallerIcon,
                            iconSize: 30,
                            backgroundColor: ColorManager.whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: context.scale(8),
                        ),
                        Text(
                          LocaleKeys.chargeScreenWithdraw.tr(),
                          style: getBoldStyle(
                              color: ColorManager.whiteColor,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.scale(102),
                ),
                Text(
                  LocaleKeys.chargeScreenCurrentBalance.tr(),
                  style: getBoldStyle(
                      color: ColorManager.whiteColor, fontSize: FontSize.s16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '',
                      style: getBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s32),
                    ),
                    SizedBox(
                      width: context.scale(8),
                    ),
                    Text(
                      LocaleKeys.chargeScreenCurrency.tr(),
                      style: getBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s20),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.scale(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: CircularIconButton(
                            containerSize: context.scale(60),
                            iconPath: AppAssets.chargeWallerIcon,
                            iconSize: 30,
                            backgroundColor: ColorManager.whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: context.scale(8),
                        ),
                        Text(
                          LocaleKeys.chargeScreenWithdraw.tr(),
                          style: getBoldStyle(
                              color: ColorManager.whiteColor,
                              fontSize: FontSize.s14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}