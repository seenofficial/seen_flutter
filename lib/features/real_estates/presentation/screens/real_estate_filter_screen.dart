import 'package:animate_do/animate_do.dart';
import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/operation_type_property_extension.dart';
import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/real_estates/presentation/controller/filter_properties_controller/filter_property_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/font_manager.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/custom_app_drop_down.dart';
import '../../../../core/components/generic_form_fields.dart';
import '../../../../core/components/loading_overlay_component.dart';
import '../../../../core/components/multi_selector_component.dart';
import '../../../../core/components/range_slider_with_text_fields_component.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/components/reusable_type_selector_component.dart';
import '../../../add_new_real_estate/presentation/components/country_selector_component.dart';
import '../../../add_new_real_estate/presentation/components/form_widget_component.dart';
import '../../../add_new_real_estate/presentation/components/property_details_fields/apartment_text_fields.dart';
import '../../../add_new_real_estate/presentation/components/property_details_fields/building_text_fields.dart';
import '../../../add_new_real_estate/presentation/components/property_details_fields/land_text_fields.dart';
import '../../../add_new_real_estate/presentation/components/property_details_fields/villa_text_fields.dart';
import '../../../add_new_real_estate/presentation/components/property_fields.dart';
import '../../../add_new_real_estate/presentation/components/state_and_city_selector_component.dart';
import '../../../home_module/home_imports.dart';
import '../components/real_estate_filteration_components/apartment_filtration_sub_types_component.dart';
import '../components/real_estate_filteration_components/building_filtration_sub_types_component.dart';
import '../components/real_estate_filteration_components/land_filtration_sub_types_component.dart';
import '../components/real_estate_filteration_components/villa_filtration_sub_types_component.dart';
import '../controller/real_estate_cubit.dart';

class RealEstateFilterScreen extends StatelessWidget {
  const RealEstateFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectLocationServiceCubit, SelectLocationServiceState>(
      builder: (context, locationState) {
        return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - context.scale(120),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTransactionTypeButtons(context),
                      SizedBox(height: context.scale(20)),
                      _buildSectionTitle('فئة العقار', context),
                      SizedBox(height: context.scale(12)),
                      _buildPropertyCategoryButtons(context),
                      _buildPropertyTypeButtons(context),
                      SizedBox(height: context.scale(20)),

                      //// show furnished only for apartment and villa
                      BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
                        builder: (context, state) {
                          bool showIsFurnished = state.currentPropertyType ==
                              PropertyType.apartment || state.currentPropertyType == PropertyType.villa || state.currentPropertyType == null;

                          return Visibility(
                            visible: showIsFurnished,
                            child: FormWidgetComponent(
                              label: 'الأثاث',
                              content: BlocBuilder<FilterPropertyCubit,
                                  FilterPropertyState>(
                                buildWhen: (previous, current) =>
                                    previous.selectedFurnishingStatuses !=
                                    current.selectedFurnishingStatuses,
                                builder: (context, state) {
                                  final selectedFurnishingStatuses =
                                      state.selectedFurnishingStatuses;

                                  return MultiSelectTypeSelectorComponent<
                                      FurnishingStatus>(
                                    values: FurnishingStatus.values,
                                    selectedTypes: selectedFurnishingStatuses,
                                    onToggle: (type) => context
                                        .read<FilterPropertyCubit>()
                                        .toggleFurnishingStatus(type),
                                    getIcon: _getFurnishedIcon,
                                    getLabel: _getFurnishedLabel,
                                    selectorWidth: 171,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),

                      /// show is licensed only for land
                      ///

                      BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
                        builder: (context, state) {
                          bool showIsLicensedState = state.currentPropertyType == PropertyType.land;

                          return Visibility(
                            visible: showIsLicensedState,
                            child: FormWidgetComponent(
                              label: 'حالة الرخصة',
                              content: BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
                                buildWhen: (previous, current) =>
                                previous.selectedLandLicenseStatuses != current.selectedLandLicenseStatuses,
                                builder: (context, state) {
                                  final selectedLandLicensed = state.selectedLandLicenseStatuses;

                                  return MultiSelectTypeSelectorComponent<LandLicenseStatus>(
                                    values: LandLicenseStatus.values,
                                    selectedTypes: selectedLandLicensed,
                                    onToggle: (type) => context.read<FilterPropertyCubit>().toggleLandLicenseStatus(type),
                                    getIcon: _getLandLicenseStatusIcon,
                                    getLabel: _getLandLicenseStatusLabel,
                                    selectorWidth: 171,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(
                        height: context.scale(16),
                      ),

                      /// todo : make indecator for loading countries
                      const CountrySelectorComponent(),

                      const StateCitySelectorComponent(),

                      /// todo : add aminties here

                      BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
                        buildWhen: (previous, current) =>
                            previous.currentPropertyOperationType !=
                            current.currentPropertyOperationType,
                        builder: (context, state) {
                          return Visibility(
                            visible: state.currentPropertyOperationType.isForRent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle(
                                    'مدة الإيجار بالشهور', context),
                                SizedBox(height: context.scale(12)),
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppTextField(
                                        initialValue: state.minNumberOfMonths,
                                        height: 40,
                                        hintText: 'الأقل',
                                        keyboardType: TextInputType.number,
                                        backgroundColor: Colors.white,
                                        borderRadius: 20,
                                        padding: EdgeInsets.zero,
                                        onChanged: (value) {
                                          context.read<FilterPropertyCubit>().updateMinNumberOfMonths(value);

                                        },
                                      ),
                                    ),
                                    SizedBox(width: context.scale(10)),
                                    Expanded(
                                      child: AppTextField(
                                        initialValue: state.maxNumberOfMonths,
                                        height: 40,
                                        hintText: 'الأكثر',
                                        keyboardType: TextInputType.number,
                                        backgroundColor: Colors.white,
                                        borderRadius: 20,
                                        padding: EdgeInsets.zero,
                                        onChanged: (value) {
                                          context.read<FilterPropertyCubit>().updateMaxNumberOfMonths(value);

                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: context.scale(20)),
                              ],
                            ),
                          );
                        },
                      ),

                      /// fields for every type
                      BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
                        buildWhen: (previous, current) =>
                            previous.currentPropertyType !=
                            current.currentPropertyType,
                        builder: (context, state) {
                          PropertyType? currentPropertyType =
                              state.currentPropertyType;
                          late PropertyFields propertyFields;

                          if (currentPropertyType != null) {
                            switch (currentPropertyType) {
                              case PropertyType.apartment:
                                propertyFields =
                                    ApartmentTextFields(fromFilter: true);
                                break;
                              case PropertyType.villa:
                                propertyFields =
                                    VillaTextFields(fromFilter: true);
                                break;
                              case PropertyType.land:
                                propertyFields = LandTextFields(fromFilter: true);
                                break;
                              case PropertyType.building:
                                propertyFields =
                                    BuildingTextFields(fromFilter: true);
                                break;
                            }

                            return Form(
                              key: context.read<FilterPropertyCubit>().formKey,
                              child: ZoomIn(
                                duration: Duration(milliseconds: 500),
                                key: ValueKey(currentPropertyType),
                                child: Column(
                                  children: [
                                    ...propertyFields.getFields(
                                        context,
                                        context
                                            .read<FilterPropertyCubit>()
                                            .formController),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),

                      _buildSectionTitle('السعر', context),
                      SizedBox(height: context.scale(12)),
                      _buildPriceRangeSlider(context),
                      SizedBox(height: context.scale(20)),
                      _buildSectionTitle('المساحة', context),
                      SizedBox(height: context.scale(12)),
                      _buildAreaRangeSlider(context),
                      SizedBox(height: context.scale(40)),
                    ],
                  ),
                ),
              ),
              _buildActionButtons(context),
            ],
          ),
          if(locationState.getCitiesState.isLoading || locationState.getCountriesState.isLoading || locationState.getStatesState.isLoading)
            LoadingOverlayComponent(
              opacity: 0,
            )
        ],
      ),
    );
      },
    );
  }

  Widget _buildTransactionTypeButtons(BuildContext context) {
    return BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
      builder: (context, state) {
        return TypeSelectorComponent<PropertyOperationType>(
          selectorWidth: 171,
          values: PropertyOperationType.values,
          currentType: state.currentPropertyOperationType,
          onTap: (type) => context
              .read<FilterPropertyCubit>()
              .changePropertyOperationType(type),
          getIcon: (type) {
            switch (type) {
              case PropertyOperationType.forSale:
                return AppAssets.forSellIcon;
              case PropertyOperationType.forRent:
                return AppAssets.rentIcon;
            }
          },
          getLabel: (type) => type.isForSale ? ' بيع' : ' إيجار',
        );
      },
    );
    ;
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style:
          getBoldStyle(color: ColorManager.blackColor, fontSize: FontSize.s12),
    );
  }

  String _getFurnishedIcon(FurnishingStatus type) {
    switch (type) {
      case FurnishingStatus.furnished:
        return AppAssets.furnishedIcon;
      case FurnishingStatus.notFurnished:
        return AppAssets.emptyIcon;
    }
  }
  String _getLandLicenseStatusIcon(LandLicenseStatus type) {
    switch (type) {
      case LandLicenseStatus.licensed:
        return AppAssets.furnishedIcon;
      case LandLicenseStatus.notLicensed:
        return AppAssets.emptyIcon;
    }
  }

  String _getFurnishedLabel(FurnishingStatus type) {
    switch (type) {
      case FurnishingStatus.furnished:
        return 'مفروش';
      case FurnishingStatus.notFurnished:
        return 'غير مفروش';
    }
  }
  String _getLandLicenseStatusLabel(LandLicenseStatus type) {
    switch (type) {
      case LandLicenseStatus.licensed:
        return 'جاهزة للبناء';
      case LandLicenseStatus.notLicensed:
        return ' تحتاج إلى تصريح';
    }
  }

  Widget _buildPropertyCategoryButtons(BuildContext context) {
    return BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
      buildWhen: (previous, current) =>
          previous.currentPropertyType != current.currentPropertyType,
      builder: (context, state) {
        final PropertyType? currentType = state.currentPropertyType;
        return TypeSelectorComponent<PropertyType>(
          selectorWidth: 82,
          values: PropertyType.values,
          currentType: currentType,
          onTap: (type) =>
              context.read<FilterPropertyCubit>().changePropertyType(type),
          getIcon: (type) {
            switch (type) {
              case PropertyType.apartment:
                return AppAssets.apartmentIcon;
              case PropertyType.villa:
                return AppAssets.villaIcon;
              case PropertyType.building:
                return AppAssets.residentialBuildingIcon;
              case PropertyType.land:
                return AppAssets.landIcon;
            }
          },
          getLabel: (type) {
            switch (type) {
              case PropertyType.apartment:
                return type.toArabic;
              case PropertyType.villa:
                return ' فيلا';
              case PropertyType.building:
                return ' عمارة';
              case PropertyType.land:
                return ' أرض';
            }
          },
        );
      },
    );
  }

  Widget _buildPropertyTypeButtons(BuildContext context) {
    /// sub type of property
    return BlocBuilder<FilterPropertyCubit, FilterPropertyState>(
      buildWhen: (previous, current) =>
          previous.currentPropertyType != current.currentPropertyType,
      builder: (context, state) {
        PropertyType? currentPropertyType = state.currentPropertyType;
        late Widget formWidget;

        if (currentPropertyType != null) {
          switch (currentPropertyType) {
            case PropertyType.apartment:
              formWidget = ApartmentFiltrationSubTypesComponent();
              break;
            case PropertyType.villa:
              formWidget = VillaFiltrationSubTypesComponent();
              break;
            case PropertyType.building:
              formWidget = BuildingFiltrationSubTypesComponent();
              break;
            case PropertyType.land:
              formWidget = LandFiltrationSubTypesComponent();
              break;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.scale(20)),
              _buildSectionTitle('نوع العقار', context),
              SizedBox(height: context.scale(12)),
              formWidget,
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildPriceRangeSlider(BuildContext context) {
    return RangeSliderWithFields(
      minValue: double.parse(AppConstants.minPrice),
      maxValue: double.parse(AppConstants.maxPrice),
      initialMinValue: double.parse(context.read<FilterPropertyCubit>().state.minPriceValue),
      initialMaxValue: double.parse(context.read<FilterPropertyCubit>().state.maxPriceValue),
      unit: 'جنية',
      onRangeChanged: (double min, double max) {
        context.read<FilterPropertyCubit>().updatePriceRange(min, max);
      },
    );
  }

  Widget _buildAreaRangeSlider(BuildContext context) {
    return RangeSliderWithFields(
      minValue: double.parse(AppConstants.minArea),
      maxValue: double.parse(AppConstants.maxArea),
      initialMinValue: double.parse(context.read<FilterPropertyCubit>().state.minAreaValue),
      initialMaxValue: double.parse(context.read<FilterPropertyCubit>().state.maxAreaValue),
      unit: 'م',
      onRangeChanged: (double min, double max) {
        context.read<FilterPropertyCubit>().updateAreaRange(min, max);
      },
    );
  }


  Widget _buildActionButtons(BuildContext context) {
    final filtrationRealEstateCubit = context.read<FilterPropertyCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: context.scale(163),
          height: context.scale(48),
          child: ElevatedButton(
            onPressed: () => filtrationRealEstateCubit.resetFilters(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD6D8DB),
              foregroundColor: Color(0xFFD6D8DB),
            ),
            child: Text(
              'الغاء الكل',
              style: TextStyle(color: ColorManager.blackColor),
            ),
          ),
        ),
        SizedBox(
          width: context.scale(163),
          height: context.scale(48),
          child: ElevatedButton(
            onPressed: () {
              var filterData = context.read<FilterPropertyCubit>().prepareDataForApi();

              final operationType = context.read<FilterPropertyCubit>().state.currentPropertyOperationType;


              context.read<RealEstateCubit>().clearPropertyList(operationType);
              context.read<RealEstateCubit>().fetchProperties(
                filters: filterData,
                operationType: operationType,
                refresh: true,
              );

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('عرض النتائج'),
          ),
        ),
      ],
    );
  }}
