import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/components/loading_overlay_component.dart';
import '../components/country_selector_component.dart';
import '../components/form_widget_component.dart';
import '../components/numbered_text_header_component.dart';
import '../components/payment_options_component.dart';
import '../components/select_amenities.dart';
import '../components/select_map_location_component.dart';
import '../components/state_and_city_selector_component.dart';
import '../controller/add_new_real_estate_cubit.dart';

class AddNewRealEstateLocationScreen extends StatelessWidget {
  AddNewRealEstateLocationScreen({super.key});

  final List<LatLng> _selectedPoints = [];

  @override
  Widget build(BuildContext context) {
    var addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();

    return BlocBuilder<SelectLocationServiceCubit, SelectLocationServiceState>(
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
                    const MapLocationComponent(),

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
    );
  }
}
