import '../../../../../core/components/generic_form_fields.dart';
import '../../../../../core/components/property_form_controller.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/local_keys.dart';
import '../../../../../core/utils/form_validator.dart';
import '../../../../home_module/home_imports.dart';
import '../property_fields.dart';

class ApartmentTextFields implements PropertyFields {
  ApartmentTextFields({
    this.fromFilter = false,
  });
  final bool fromFilter;
  @override
  List<Widget> getFields(
      BuildContext context, PropertyFormController controller) {
    return [
      if(!fromFilter)
      GenericFormField(
        label: 'المساحة',
        hintText: 'أدخل المساحة بالمتر المربع',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.areaIcon,
        controller: controller.getController(LocalKeys.apartmentAreaController),
        validator: (value) =>
            FormValidator.validatePositiveNumber(value, fieldName: 'المساحة'),
      ),
      GenericFormField(
        label: 'الطابق',
        hintText: '"أدخل رقم الطابق',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.landIcon,
        controller:
            controller.getController(LocalKeys.apartmentFloorsController),
        validator: (value) =>
            FormValidator.validatePositiveNumber(value, fieldName: 'الطوابق'),
      ),
      GenericFormField(
        label: 'عدد الغرف',
        hintText: 'حدد عدد الغرف',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.bedIcon,
        controller:
            controller.getController(LocalKeys.apartmentRoomsController),
        validator: (value) =>
            FormValidator.validatePositiveNumber(value, fieldName: 'عدد الغرف'),
      ),
      GenericFormField(
        label: 'عدد الحمامات',
        hintText: 'حدد عدد الحمامات',
        keyboardType: TextInputType.number,
        iconPath: AppAssets.bedIcon,
        controller:
            controller.getController(LocalKeys.apartmentBathRoomsController),
        validator: (value) => FormValidator.validatePositiveNumber(value,
            fieldName: 'عدد الحمامات'),
      ),
    ];
  }
}
