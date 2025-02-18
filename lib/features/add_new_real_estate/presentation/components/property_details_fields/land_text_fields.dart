import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';
import '../property_fields.dart';

class LandTextFields implements PropertyFields {
  @override
  List<Widget> getFields(BuildContext context, PropertyFormController controller) {
    return [
      GenericFormField(
        label: 'المساحة',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController('land_area'),
      ),

    ];
  }
}