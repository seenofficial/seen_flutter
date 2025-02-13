import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/components/custom_bottom_sheet.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/property_operation_type_extension.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:enmaa/features/real_estates/presentation/screens/real_estate_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/card_listing_shimmer.dart';
import '../../../../core/components/custom_tab.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/translation/locale_keys.dart';
import '../../../../core/utils/enums.dart';
import '../../../home_module/presentation/components/real_state_card_component.dart';
import '../../../home_module/presentation/components/services_list_shimmer.dart';
import '../../../main_services_layout/main_service_layout_screen.dart';



class RealStateScreen extends StatefulWidget {
  const RealStateScreen({super.key});

  @override
  State<RealStateScreen> createState() => _RealStateScreenState();
}

class _RealStateScreenState extends State<RealStateScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openFilterBottomSheet() {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    showModalBottomSheet(
      context: rootContext,
      backgroundColor: ColorManager.greyShade,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return const CustomBottomSheet(
          widget: RealEstateFilterScreen(),
          headerText: "التصفية",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ServiceLocator.getIt<RealEstateCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.greyShade,
        body: Column(
          children: [
            AppBarComponent(
              appBarTextMessage: LocaleKeys.chooseYourIdealPropertyEasily.tr(),
            ),
            Row(
              children: [
                AppTextField(
                  onTap: _openFilterBottomSheet,
                  width: context.scale(235),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(16),
                    vertical: context.scale(8),
                  ),
                  hintText: 'ابحث عن كل ما تريد معرفته ...',
                  prefixIcon: Icon(Icons.search, color: ColorManager.blackColor),
                ),
                ButtonAppComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  width: context.scale(111),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(RoutersNames.addNewRealEstateScreen);
                  },
                  buttonContent: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgImageComponent(iconPath: AppAssets.plusIcon),
                      Text(
                        LocaleKeys.addYourRealState.tr(),
                        style: getMediumStyle(color: ColorManager.whiteColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            TabBar(
              padding: EdgeInsets.symmetric(
                horizontal: context.scale(8),
                vertical: context.scale(6),
              ),
              controller: _tabController,
              indicator: const BoxDecoration(color: Colors.transparent),
              dividerColor: Colors.transparent,
              tabs: [
                CustomTab(
                  text: LocaleKeys.forSale.tr(),
                  isSelected: _tabController.index == 0,
                ),
                CustomTab(
                  text: LocaleKeys.forRent.tr(),
                  isSelected: _tabController.index == 1,
                ),
              ],
            ),
            BlocBuilder<RealEstateCubit, RealEstateState>(
              builder: (context, state) {
                switch (state.getPropertiesState) {
                  case RequestState.loading:
                  case RequestState.initial:
                  return CardShimmerList(
                    scrollDirection: Axis.vertical,
                    cardHeight: context.scale(282),
                    cardWidth: context.screenWidth,
                    numberOfCards: 3,
                  );
                  case RequestState.loaded:

                    return Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildPropertyList(state, PropertyOperationType.forSale),
                          _buildPropertyList(state, PropertyOperationType.forRent),
                        ],
                      ),
                    );

                  case RequestState.error:
                    return Center(
                      child: Text(
                        state.getPropertiesError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyList(RealEstateState state, PropertyOperationType type) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: state.properties.length,
      itemBuilder: (context, index) {
        final property = state.properties[index];
        return Visibility(
          visible: property.operation.toOperationType() == type,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RealStateCardComponent(
              width: MediaQuery.of(context).size.width,
              height: context.scale(290),
              currentProperty: property,
            ),
          ),
        );
      },
    );
  }
}
