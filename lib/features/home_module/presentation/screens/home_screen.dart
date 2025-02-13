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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Screen not found for category: $serviceName'),
                                ),
                              );
                            }
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: context.scale(24)),
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

                                      return ServicesListingWidget(
                                        seeMoreAction: () {},
                                        listingWidget: SizedBox(
                                          height: context.scale(241),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: state.properties.length,
                                            itemBuilder: (context, index) {
                                              final property = state.properties[index];
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
                              )
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
