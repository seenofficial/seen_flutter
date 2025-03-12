import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/preview_property/presentation/controller/preview_property_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/managers/value_manager.dart';
import '../../../../core/components/loading_overlay_component.dart';
import '../../../../core/components/reusable_type_selector_component.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/components/warning_message_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/enums.dart';
import '../../../add_new_real_estate/presentation/components/numbered_text_header_component.dart';
import '../../../home_module/home_imports.dart';

class ConfirmPreviewPaymentScreen extends StatefulWidget {
  const ConfirmPreviewPaymentScreen({super.key , required this.propertyId});

  final String propertyId ;
  @override
  State<ConfirmPreviewPaymentScreen> createState() => _ConfirmPreviewPaymentScreenState();
}

class _ConfirmPreviewPaymentScreenState extends State<ConfirmPreviewPaymentScreen> {
  @override
  void initState() {
    context.read<PreviewPropertyCubit>().getInspectionAmountToBePaid(widget.propertyId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreviewPropertyCubit, PreviewPropertyState>(
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(context.scale(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NumberedTextHeaderComponent(
                    number: '2',
                    text: 'إتمام الدفع',
                  ),
                  SizedBox(height: context.scale(16)),
                  Text(
                    ' تفاصيل الدفع',
                    style: getBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s16,
                    ),
                  ),
                  SizedBox(height: context.scale(12)),
                  Container(
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
                          'المبلغ المطلوب سداده :',
                          style: getSemiBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: FontSize.s14,
                          ),
                        ),
                        Text(
                          '${state.inspectionAmount} جنية',
                          style: getBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.scale(16)),


                  TypeSelectorComponent<String>(
                    selectorWidth: 171,
                    values: ['بطاقة الائتمان', 'المحفظة'],
                    currentType: state.currentPaymentMethod,
                    onTap: (type) {
                      context.read<PreviewPropertyCubit>().changePaymentMethod(type);
                    },
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
            ),

            if(state.addNewPreviewTimeState.isLoading)
              LoadingOverlayComponent(
                opacity: 0,
                text: ' جاري تأكيد الدفع',
              ),
            if(state.getInspectionAmountState.isLoading)
              LoadingOverlayComponent(
                opacity: 0,
                text: 'جاري تحميل البيانات',
              ),
          ],
        );
      },
    );
  }
}
