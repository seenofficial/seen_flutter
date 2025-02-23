import '../../../../../core/components/app_text_field.dart';
import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/components/svg_image_component.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';
import '../form_widget_component.dart';
import '../property_fields.dart';
import '../../../../../core/utils/form_validator.dart';

class BuildingTextFields implements PropertyFields {
  @override
  List<Widget> getFields(BuildContext context, PropertyFormController controller) {
    return [
      GenericFormField(
        label: 'المساحة ',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController('building_area'),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'المساحة'),
      ),
      GenericFormField(
        label: 'عدد الطوابق',
        hintText: 'حدد عدد الطوابق',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.landIcon,
        controller: controller.getController('building_floors'),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'عدد الطوابق'),
      ),
      GenericFormField(
        label: 'عدد الشقق في كل طابق',
        hintText: 'حدد عدد الغرف',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.apartmentIcon,
        controller: controller.getController('number_of_apartments_per_floor'),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'عدد الشقق في كل طابق'),
      ),
    ];
  }
}