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

class LandTextFields implements PropertyFields {
  @override
  List<Widget> getFields(BuildContext context, PropertyFormController controller) {
    return [
      GenericFormField(
        label: 'المساحة',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController(LocalKeys.landAreaController),
        validator: (value) => FormValidator.validatePositiveNumber(value, fieldName: 'المساحة'),
      ),
    ];
  }
}