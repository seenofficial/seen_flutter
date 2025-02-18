import 'package:enmaa/core/extensions/property_sub_types/apartment_type_extension.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/controller/add_new_real_estate_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/utils/enums.dart';
import '../reusable_type_selector_component.dart';

class ApartmentSubTypesComponent extends StatelessWidget {
  const ApartmentSubTypesComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();

    return BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(
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
      default:
        return '';
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
      default:
        return '';
    }
  }
}
