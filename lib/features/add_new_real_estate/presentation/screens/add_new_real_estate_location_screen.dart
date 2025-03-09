import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/components/loading_overlay_component.dart';
import '../../../../core/services/map_services/map_services_DI.dart';
import '../../../../core/services/map_services/presentation/controller /map_services_cubit.dart';
import '../../../../core/services/map_services/presentation/screens/searchable_map_component.dart';
import '../../../../core/services/service_locator.dart';
import '../components/country_selector_component.dart';
import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';
import '../components/payment_options_component.dart';
import '../components/select_amenities.dart';
import '../components/select_map_location_component.dart';
import '../components/state_and_city_selector_component.dart';
import '../controller/add_new_real_estate_cubit.dart';

class AddNewRealEstateLocationScreen extends StatelessWidget {
  const AddNewRealEstateLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();

    return BlocProvider(
      create: (context) {
        MapServicesDi().setup();
        return MapServicesCubit(
          ServiceLocator.getIt(),
        );
      },
      child: BlocBuilder<MapServicesCubit, MapServicesState>(
        builder: (context, state) {
          return Stack(
            children: [

               BlocBuilder<MapServicesCubit, MapServicesState>(
                buildWhen: (previous, current) =>
                previous.showSuggestionsList != current.showSuggestionsList,
                builder: (context, state) {
                  return Visibility(
                    visible: state.showSuggestionsList,
                    child: GestureDetector(
                      onTap: () {
                        print('Tapped Outside');
                        context.read<MapServicesCubit>().changeVisibilityOfSuggestionsList();
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),

              BlocBuilder<SelectLocationServiceCubit, SelectLocationServiceState>(
                buildWhen: (previous, current) =>
                previous.getCountriesState != current.getCountriesState ||
                    previous.getStatesState != current.getStatesState ||
                    previous.getCitiesState != current.getCitiesState,
                builder: (context, state) {
                  return Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: addNewRealEstateCubit.locationForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const NumberedTextHeaderComponent(
                                number: '3',
                                text: ' الموقع والمميزات',
                              ),
                              SizedBox(height: context.scale(20)),

                              // Country Selector
                              const CountrySelectorComponent(),

                              // State and City Selector
                              const StateCitySelectorComponent(),

                              // Map Location
                              SearchableMapComponent(
                                onLocationSelected: (LatLng location) {
                                  addNewRealEstateCubit.changeSelectedLocation(location);
                                },
                              ),

                              SizedBox(height: context.scale(20)),

                              // Amenities
                              const FormWidgetComponent(
                                label: 'الخدمات والمرافق القريبة',
                                content: SelectAmenities(),
                              ),

                              // Payment Options
                              const PaymentOptionsComponent(),
                            ],
                          ),
                        ),
                      ),
                      if (state.getCountriesState.isLoading ||
                          state.getStatesState.isLoading ||
                          state.getCitiesState.isLoading)
                        const LoadingOverlayComponent(opacity: 0),
                    ],
                  );
                },
              ),


            ],
          );
        },
      ),
    );
  }
}