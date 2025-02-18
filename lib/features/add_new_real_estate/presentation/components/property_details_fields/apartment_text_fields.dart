import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../home_module/home_imports.dart';
import '../property_fields.dart';

class ApartmentTextFields implements PropertyFields {
  @override
  List<Widget> getFields(BuildContext context, PropertyFormController controller) {
    return [
      GenericFormField(
        label: 'المساحة',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController('apartment_area'),
      ),
      GenericFormField(
        label: ' الطوابق',
        hintText: '',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.landIcon,
        controller: controller.getController('apartment_floors'),
      ),
      GenericFormField(
        label: 'عدد الغرف',
        hintText: 'أدخل عدد الغرف',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.bedIcon,
        controller: controller.getController('apartment_rooms'),
      ),
      GenericFormField(
        label: 'عدد الحمامات',
        hintText: 'أدخل عدد الغرف',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.bedIcon,
        controller: controller.getController('apartment_bathrooms'),
      ),
    ];
  }
}