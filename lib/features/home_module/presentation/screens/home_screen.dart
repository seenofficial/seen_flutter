import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/features/real_estates/domain/entities/base_property_entity.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/home_module/presentation/components/categories_list.dart';
import 'package:enmaa/features/home_module/presentation/controller/home_bloc.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/core/components/app_bar_component.dart';
import 'package:enmaa/core/components/app_text_field.dart';
import 'package:enmaa/core/services/service_locator.dart';
import '../../../../configuration/managers/value_manager.dart';
import '../../../../core/components/card_listing_shimmer.dart';
import '../../../../core/utils/enums.dart';
import '../../../main_services_layout/app_services.dart';
import '../../../main_services_layout/main_service_layout_screen.dart';
import '../../domain/entities/app_service_entity.dart';
import '../../home_imports.dart';
import '../components/real_state_card_component.dart';
import '../components/services_list_shimmer.dart';
import '../components/services_listing_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  List<PropertyEntity> filterPropertiesByType(List<PropertyEntity> properties, String type) {
    return properties.where((property) => property.propertyType == type).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManager.greyShade,
          body: Column(
            children: [
              const AppBarComponent(
                appBarTextMessage: 'كل الخيارات بين يديك',
              ),
              AppTextField(
                hintText: 'ابحث عن كل ما تريد معرفته ...',
                prefixIcon:
                    Icon(Icons.search, color: ColorManager.blackColor),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeBloc>().add(FetchBanners());
                    context.read<HomeBloc>().add(FetchAppServices());
                    context.read<RealEstateCubit>().fetchProperties();
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
                                  builder: (context) => MainServicesScreen(
                                      serviceName: serviceName),
                                ),
                              );
                            } else {
                              CustomSnackBar.show(context: context, message: '$serviceName غير متاحه الان ويتم العمل عليها', type: SnackBarType.error);
                            }
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4, // Four types of properties
                          itemBuilder: (context, index) {
                            final List<String> propertyTypes = ['apartment', 'land', 'building', 'villa'];
                            final List<String> propertyTypeTitles = ['شقق', 'اراضي', 'مباني', 'فلل'];
                            final String propertyType = propertyTypes[index];

                            return Padding(
                              padding: EdgeInsets.only(top: context.scale(24)),
                              child: BlocBuilder<RealEstateCubit, RealEstateState>(
                                buildWhen: (previous, current) =>
                                previous.getPropertiesState != current.getPropertiesState,
                                builder: (context, state) {
                                  switch (state.getPropertiesState) {
                                    case RequestState.loading || RequestState.initial:
                                      return SizedBox(
                                        height: context.scale(241),
                                        child: CardShimmerList(
                                          scrollDirection: Axis.horizontal,
                                          cardWidth: context.scale(209),
                                          cardHeight: context.scale(241),
                                        ),
                                      );

                                    case RequestState.loaded:
                                      final filteredProperties = filterPropertiesByType(state.properties, propertyType);

                                      return ServicesListingWidget(
                                        seeMoreAction: () {
                                          // Handle see more action for each property type
                                        },
                                        listingWidget: SizedBox(
                                          height: context.scale(241),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: filteredProperties.length,
                                            itemBuilder: (context, index) {
                                              final property = filteredProperties[index];
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
                                        title: '  ${propertyTypeTitles[index]} بالقرب منك', // Custom title based on property type
                                      );

                                    case RequestState.error:
                                      return Center(
                                        child: Text(
                                          state.getPropertiesError,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      );
                                  }
                                },
                              ),
                            );
                          },
                        ),                      ],
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
