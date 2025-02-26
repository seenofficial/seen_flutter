import '../../../../../core/components/app_text_field.dart';
import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/local_keys.dart';
import '../../../../home_module/home_imports.dart';
import '../form_widget_component.dart';
import '../property_fields.dart';
import '../../../../../core/utils/form_validator.dart';

class BuildingTextFields implements PropertyFields {

  const BuildingTextFields({this.fromFilter = false});
  final bool fromFilter ;
  @override
  List<Widget> getFields(BuildContext context, PropertyFormController controller) {
    return [
      if(!fromFilter)
        GenericFormField(
        label: 'المساحة ',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController(LocalKeys.buildingAreaController),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'المساحة'),
      ),
      GenericFormField(
        label: 'عدد الطوابق',
        hintText: 'حدد عدد الطوابق',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.landIcon,
        controller: controller.getController(LocalKeys.buildingFloorsController),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'عدد الطوابق'),
      ),
      GenericFormField(
        label: 'عدد الشقق في كل طابق',
        hintText: 'حدد عدد الغرف',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.apartmentIcon,
        controller: controller.getController(LocalKeys.buildingApartmentsPerFloorController),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'عدد الشقق في كل طابق'),
      ),
    ];
  }
}