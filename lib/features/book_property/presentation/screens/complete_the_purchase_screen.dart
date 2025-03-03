import 'package:enmaa/core/extensions/context_extension.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/managers/value_manager.dart';
import '../../../../core/components/reusable_type_selector_component.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/components/warning_message_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../add_new_real_estate/presentation/components/numbered_text_header_component.dart';
import '../../../home_module/home_imports.dart';

class CompleteThePurchaseScreen extends StatelessWidget {
  const CompleteThePurchaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppPadding.p16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NumberedTextHeaderComponent(
            number: '٣',
            text: 'إتمام الدفع',
          ),
          SizedBox(height: context.scale(20)),
          _buildSectionTitle('تفاصيل الدفع'),
          SizedBox(height: context.scale(20)),
          PaymentDetailRow(
            label: 'المبلغ المطلوب سداده  : ',
            value: '100.000 جنية',
          ),
          SizedBox(height: context.scale(20)),
          _buildSectionTitle('مراجعة البيانات'),
          SizedBox(height: context.scale(20)),
          ReviewDataCard(
            details: [
              {'label': 'الاسم الكامل   : ', 'value': 'Amr Abd ElHamed', 'icon': AppAssets.birthDayIcon},
              {'label': 'رقم الموبايل   : ', 'value': '01005734569', 'icon': AppAssets.phoneIcon},
              {'label': 'رقم الهويه  : ', 'value': '12345678912', 'icon': AppAssets.cardIdentityIcon},
              {'label': 'تاريخ الميلاد  : ', 'value': '26-5-2001', 'icon': AppAssets.birthDayIcon},
              {'label': 'تاريخ الانتهاء  : ', 'value': '26-5-2001', 'icon': AppAssets.endTimeIcon},
            ],
          ),
          SizedBox(height: context.scale(20)),

          Text(
            'طرق الدفع',
            style: getBoldStyle(color: ColorManager.blackColor , fontSize: FontSize.s16 ),
          ),

          SizedBox(height: context.scale(12)),
          TypeSelectorComponent<String>(
            selectorWidth: 171,
            values: ['بطاقة الائتمان', 'المحفظة'],
            currentType: 'المحفظة',
            onTap: (type) {},
            getIcon: (type) {
              switch (type) {
                case 'بطاقة الائتمان':
                  return AppAssets.creditCardIcon;
                case 'المحفظة':
                  return AppAssets.walletIcon;
                default:
                  return AppAssets.creditCardIcon;
              }
            },
            getLabel: (type) => type,
          ),
          SizedBox(height: context.scale(20)),
          WarningMessageComponent(
            text: 'يرجى التأكد من صحة بيانات الدفع قبل المتابعة، حيث لا يمكن استرجاع مبلغ عربون الحجز بعد إتمام العملية',
          ),

          SizedBox(height: context.scale(20)),

          WarningMessageComponent(
            text: 'جميع المعاملات المالية تتم وفقًا لمعايير الأمان وحماية البيانات لضمان تجربة دفع آمنة.',
          ),

        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: getBoldStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
    );
  }
}

class PaymentDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const PaymentDetailRow({
    required this.label,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(54),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(AppPadding.p16),
      child: Row(
        children: [
          SvgImageComponent(iconPath: AppAssets.apartmentIcon),
          SizedBox(width: context.scale(8)),
          Text(
            label,
            style: getSemiBoldStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s14,
            ),
          ),
          Text(
            value,
            style: getBoldStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s16,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewDataCard extends StatelessWidget {
  final List<Map<String, String>> details;

  const ReviewDataCard({
    required this.details,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(194),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: details
            .map((detail) => DetailRow(
          label: detail['label']!,
          value: detail['value']!,
          iconPath: detail['icon']!,
        ))
            .toList(),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final String iconPath;

  const DetailRow({
    required this.label,
    required this.value,
    required this.iconPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgImageComponent(iconPath: iconPath, width: 20, height: 20),
        SizedBox(width: context.scale(8)),
        Text(
          label,
          style: getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s14,
          ),
        ),
        Text(
          value,
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s16,
          ),
        ),
      ],
    );
  }
}
