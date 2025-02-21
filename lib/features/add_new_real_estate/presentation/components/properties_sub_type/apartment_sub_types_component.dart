import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/property_sub_types/apartment_type_extension.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/controller/add_new_real_estate_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/enums.dart';
import '../form_widget_component.dart';
import '../reusable_type_selector_component.dart';

class ApartmentSubTypesComponent extends StatelessWidget {
  const ApartmentSubTypesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();

    return Column(
      children: [
        BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(
          buildWhen: (previous, current) =>
              previous.currentApartmentType != current.currentApartmentType,

          builder: (context, state) {
            final currentApartmentType = state.currentApartmentType;

            return TypeSelectorComponent<ApartmentType>(
              values: ApartmentType.values,
              currentType: currentApartmentType,
              onTap: (type) => addNewRealEstateCubit.changeApartmentType(type),
              getIcon: _getApartmentIcon,
              getLabel: _getApartmentLabel,
              selectorWidth: 114,
            );
          },
        ),

        SizedBox(
          height: context.scale(16),
        ),

        FormWidgetComponent(
          label: 'الأثاث',
          content: BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(

            buildWhen: (previous, current) =>
                previous.currentFurnishingStatus !=
                current.currentFurnishingStatus,
            builder: (context, state) {
              final currentFurnishingStatus = state.currentFurnishingStatus;

              return TypeSelectorComponent<FurnishingStatus>(
                values: FurnishingStatus.values,
                currentType: currentFurnishingStatus,
                onTap: (type) {
                  addNewRealEstateCubit.changeFurnishingStatus(type);
                },
                getIcon: _getFurnishedIcon,
                getLabel: _getFurnishedLabel,
                selectorWidth: 171,
              );
            },
          ),
        ),
      ],
    );
  }

  String _getApartmentIcon(ApartmentType type) {
    switch (type) {
      case ApartmentType.duplex:
        return AppAssets.townhouseIcon;
      case ApartmentType.penthouse:
        return AppAssets.villaIcon;
      case ApartmentType.studio:
        return AppAssets.residentialBuildingIcon;
    }
  }

  String _getApartmentLabel(ApartmentType type) {
    switch (type) {
      case ApartmentType.duplex:
        return ' دوبلكس';
      case ApartmentType.penthouse:
        return ' بنتهاوس';
      case ApartmentType.studio:
        return ' ستوديو';

    }
  }

  String _getFurnishedIcon(FurnishingStatus type) {
    switch (type) {
      case FurnishingStatus.furnished:
        return AppAssets.furnishedIcon;
      case FurnishingStatus.notFurnished:
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
}
