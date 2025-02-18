import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';
import '../property_fields.dart';

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
      ),
      GenericFormField(
        label: 'عدد الطوابق',
        hintText: 'أدخل عدد الطوابق',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.landIcon,
        controller: controller.getController('building_floors'),
      ),
      GenericFormField(
        label: 'عدد الشقق في كل طابق',
        hintText: 'أدخل عدد الغرف',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.apartmentIcon,
        controller: controller.getController('number_of_apartments_per_floor'),
      ),
    ];
  }
}