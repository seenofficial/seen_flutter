import 'package:enmaa/core/extensions/property_type_extension.dart';
import 'package:enmaa/core/services/select_location_service/presentation/controller/select_location_service_cubit.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../controller/add_new_real_estate_cubit.dart';

class AddNewRealEstateButtons extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final Duration animationTime;

  const AddNewRealEstateButtons({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.animationTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 32.0,
        top: 16.0,
      ),
      child: AnimatedSwitcher(
        duration: animationTime,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: currentPage == 0
            ? SizedBox(
          key: const ValueKey<int>(0),
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (context.read<AddNewRealEstateCubit>().formKey.currentState!.validate()) {
                pageController.nextPage(
                  duration: animationTime,
                  curve: Curves.easeIn,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('التالي'),
          ),
        )
            : Row(
          key: const ValueKey<int>(1),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 175,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage > 0) {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 1),
                      curve: Curves.easeInOutSine,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD6D8DB),
                  foregroundColor: const Color(0xFFD6D8DB),
                ),
                child: Text(
                  'السابق',
                  style: TextStyle(color: ColorManager.blackColor),
                ),
              ),
            ),
            BlocBuilder<SelectLocationServiceCubit, SelectLocationServiceState>(
              builder: (context, locationState) {
                return BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(
                  builder: (context, state) {
                    final bool sendData = state.selectedLocation != null && locationState.selectedCity != null;
                    final bool isEditMode = state.propertyDetailsEntity != null;

                    return AnimatedSize(
                      duration: animationTime,
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        width: 175,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            final addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();
                            if (currentPage < 2) {
                              if (addNewRealEstateCubit.priceForm.currentState!.validate() &&
                                  addNewRealEstateCubit.validateImages()) {
                                pageController.nextPage(
                                  duration: animationTime,
                                  curve: Curves.easeIn,
                                );
                              }
                            } else {
                              if (addNewRealEstateCubit.locationForm.currentState!.validate() &&
                                  state.selectedLocation != null) {
                                final locationCubit = ServiceLocator.getIt<SelectLocationServiceCubit>();
                                if (isEditMode) {
                                  // Update existing property
                                  final propertyId = state.propertyDetailsEntity!.id.toString();
                                  if (state.currentPropertyType.isApartment) {
                                    addNewRealEstateCubit.updateApartment(
                                      apartmentId: propertyId,
                                      replaceImages: true,
                                      mainImageId: null,
                                      locationServiceCubit: locationCubit,
                                    );
                                  } else if (state.currentPropertyType.isVilla) {
                                    addNewRealEstateCubit.updateVilla(
                                      villaId: propertyId,
                                      replaceImages: true,
                                      mainImageId: null,
                                      locationServiceCubit: locationCubit,
                                    );
                                  } else if (state.currentPropertyType.isBuilding) {
                                    addNewRealEstateCubit.updateBuilding(
                                      buildingId: propertyId,
                                      replaceImages: true,
                                      mainImageId: null,
                                      locationServiceCubit: locationCubit,
                                    );
                                  } else if (state.currentPropertyType.isLand) {
                                    addNewRealEstateCubit.updateLand(
                                      landId: propertyId,

                                      locationServiceCubit: locationCubit,
                                    );
                                  }
                                } else {
                                  // Add new property
                                  if (state.currentPropertyType.isApartment) {
                                    addNewRealEstateCubit.addNewApartment(locationCubit);
                                  } else if (state.currentPropertyType.isVilla) {
                                    addNewRealEstateCubit.addNewVilla(locationCubit);
                                  } else if (state.currentPropertyType.isBuilding) {
                                    addNewRealEstateCubit.addNewBuilding(locationCubit);
                                  } else if (state.currentPropertyType.isLand) {
                                    addNewRealEstateCubit.addNewLand(locationCubit);
                                  }
                                }
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: sendData || currentPage != 2
                                ? ColorManager.primaryColor
                                : ColorManager.primaryColor2,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            currentPage == 2 ? (isEditMode ? 'تحديث' : 'إرسال') : 'التالي',
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}