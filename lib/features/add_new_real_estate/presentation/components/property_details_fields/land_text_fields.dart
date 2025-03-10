import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/app_text_field.dart';
import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/components/reusable_type_selector_component.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/local_keys.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../home_module/home_imports.dart';
import '../../controller/add_new_real_estate_cubit.dart';
import '../form_widget_component.dart';
import '../property_fields.dart';
import '../../../../../core/utils/form_validator.dart';

class LandTextFields implements PropertyFields {

  const LandTextFields({this.fromFilter = false});
  final bool fromFilter ;
  @override
  List<Widget> getFields(BuildContext context, PropertyFormController controller) {
    return [
      if(!fromFilter)
        GenericFormField(
        label: 'المساحة',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController(LocalKeys.landAreaController),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'المساحة'),
      ),


      if(!fromFilter)
        FormWidgetComponent(
        label: 'حالة الرخصة ',
        content: BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(

          buildWhen: (previous, current) =>
          previous.landLicenseStatus !=
              current.landLicenseStatus,
          builder: (context, state) {
            final currentLicenceLand = state.landLicenseStatus;

            return TypeSelectorComponent<LandLicenseStatus>(
              values: LandLicenseStatus.values,
              currentType: currentLicenceLand,
              onTap: (type) {
                context.read<AddNewRealEstateCubit>().changeLandLicence(type);
              },
              getIcon: _getLandLicenceIcon,
              getLabel: _getLandLicenceLabel,
              selectorWidth: 171,
            );
          },
        ),
      ),


    ];




  }

  String _getLandLicenceIcon(LandLicenseStatus type) {
    switch (type) {
      case LandLicenseStatus.licensed:
        return AppAssets.readyForBuilding;
      case LandLicenseStatus.notLicensed:
        return AppAssets.needLicenceIcon;

    }
  }

  String _getLandLicenceLabel(LandLicenseStatus type) {
    switch (type) {
      case LandLicenseStatus.licensed:
        return 'جاهزة للبناء';
      case LandLicenseStatus.notLicensed:
        return 'تحتاج إلى تصريح';

    }
  }

}