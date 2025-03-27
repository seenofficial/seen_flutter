import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/core/services/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/home_module/presentation/components/categories_list.dart';
import 'package:enmaa/features/home_module/presentation/controller/home_bloc.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/core/components/app_bar_component.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import '../../../../configuration/managers/value_manager.dart';
import '../../../../core/components/card_listing_shimmer.dart';
import '../../../../core/utils/enums.dart';
import '../../../main_services_layout/app_services.dart';
import '../../../main_services_layout/main_service_layout_screen.dart';
import '../../home_imports.dart';
import '../components/real_state_card_component.dart';
import '../components/services_listing_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.greyShade,
          body: Column(
            children: [
              AppBarComponent(
                appBarTextMessage: LocaleKeys.homeAppBarMessage.tr(),
                homeBloc: context.read<HomeBloc>(),
              ),
              AppTextField(
                hintText: LocaleKeys.homeSearchHint.tr(),
                prefixIcon: Icon(Icons.search, color: ColorManager.blackColor),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    state.properties.forEach((propertyType, propertyData) {
                      if (propertyData.state != RequestState.initial) {
                        context.read<HomeBloc>().add(
                          FetchNearByProperties(
                            propertyType: propertyType,
                            location: SharedPreferencesService().getValue('city_id').toString() ?? '',
                          ),
                        );
                      }
                    });
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ServicesList(
                          onServicePressed: (serviceName) {
                            if (appServiceScreens[serviceName] != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainServicesScreen(serviceName: serviceName),
                                ),
                              );
                            } else {
                              CustomSnackBar.show(
                                context: context,
                                message: '$serviceName ${LocaleKeys.homeServiceNotAvailable.tr()}',
                                type: SnackBarType.error,
                              );
                            }
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            final List<PropertyType> propertyTypes = [
                              PropertyType.apartment,
                              PropertyType.land,
                              PropertyType.building,
                              PropertyType.villa,
                            ];
                            final List<String> propertyTypeKeys = [
                              LocaleKeys.homeApartments.tr(),
                              LocaleKeys.homeLands.tr(),
                              LocaleKeys.homeBuildings.tr(),
                              LocaleKeys.homeVillas.tr(),
                            ];
                            final PropertyType propertyType = propertyTypes[index];

                            return Padding(
                              padding: EdgeInsets.only(top: context.scale(24)),
                              child: VisibilityDetector(
                                key: Key('property_section_${propertyType.toString()}'),
                                onVisibilityChanged: (info) {
                                  if (info.visibleFraction > 0.1) {
                                    final propertyData = state.properties[propertyType];
                                    if (propertyData == null ||
                                        (propertyData.state != RequestState.loaded &&
                                            propertyData.state != RequestState.loading)) {
                                      context.read<HomeBloc>().add(
                                        FetchNearByProperties(
                                          propertyType: propertyType,
                                          location: SharedPreferencesService().getValue('city_id').toString() ?? '',
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: BlocBuilder<HomeBloc, HomeState>(
                                  buildWhen: (previous, current) {
                                    final previousData = previous.properties[propertyType];
                                    final currentData = current.properties[propertyType];
                                    return previousData != currentData;
                                  },
                                  builder: (context, state) {
                                    final propertyData = state.properties[propertyType];
                                    final requestState = propertyData?.state ?? RequestState.initial;

                                    switch (requestState) {
                                      case RequestState.loading:
                                      case RequestState.initial:
                                        return SizedBox(
                                          height: context.scale(241),
                                          child: CardShimmerList(
                                            scrollDirection: Axis.horizontal,
                                            cardWidth: context.scale(209),
                                            cardHeight: context.scale(241),
                                          ),
                                        );

                                      case RequestState.loaded:
                                        final properties = propertyData?.properties ?? [];

                                        if (properties.isEmpty) {
                                          return Center(
                                            child: Text(
                                              '${LocaleKeys.homeNoAvailable.tr()} ${propertyTypeKeys[index]}',
                                              style: TextStyle(color: ColorManager.blackColor),
                                            ),
                                          );
                                        }

                                        return ServicesListingWidget(
                                          seeMoreAction: () {},
                                          listingWidget: SizedBox(
                                            height: context.scale(241),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: properties.length,
                                              itemBuilder: (context, index) {
                                                final property = properties[index];
                                                return Padding(
                                                  padding: EdgeInsets.only(right: context.scale(AppPadding.p16)),
                                                  child: RealStateCardComponent(
                                                    width: context.scale(209),
                                                    height: context.scale(241),
                                                    currentProperty: property,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          title: '${propertyTypeKeys[index]} ${LocaleKeys.homeNearby.tr()}', // Translated
                                        );

                                      case RequestState.error:
                                        return Center(
                                          child: Text(
                                            propertyData?.errorMessage ?? LocaleKeys.homeErrorOccurred.tr(), // Translated
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        );
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}