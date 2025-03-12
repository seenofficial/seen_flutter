
 import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/components/custom_snack_bar.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/preview_property/presentation/controller/preview_property_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
 import '../../../../core/components/button_app_component.dart';
 import '../../../home_module/home_imports.dart';
import '../../data/models/add_new_preview_time_request_model.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key , required this.currentPage, required this.pageController , required this.propertyId});
  final int currentPage ;
  final PageController pageController  ;
  final String propertyId ;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: context.scale(25),
      left: context.scale(16),
      right: context.scale(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ButtonAppComponent(
            width: 171,
            height: 46,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: ColorManager.grey3,
              borderRadius: BorderRadius.circular(context.scale(24)),
            ),
            buttonContent: Center(
              child: Text(
                currentPage == 0 ?  'إلغاء' : 'السابق',
                style: getMediumStyle(
                  color: ColorManager.blackColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            onTap: () {
              if(currentPage == 0 ) {
                Navigator.of(context).pop();
              } else {
                pageController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          BlocConsumer<PreviewPropertyCubit, PreviewPropertyState>(
            listener: (context, state) {
              if(state.addNewPreviewTimeState.isLoaded) {
                CustomSnackBar.show(context: context, message: 'تم تأكيد موعد معاينتك للعقار، وسيتم التواصل معك في أقرب وقت لتأكيد التفاصيل النهائية.', type: SnackBarType.success);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final bool canConfirm = state.selectedDate != null && state.selectedTime != null ;
              final bool canSendRequest = state.getInspectionAmountState.isLoaded ;
              return ButtonAppComponent(
                width: 171,
                height: 46,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: canConfirm ? ColorManager.primaryColor : canSendRequest ? ColorManager.primaryColor :  ColorManager.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(context.scale(24)),
                ),
                buttonContent: Center(
                  child: Text(
                    currentPage == 0 ? 'التالي' : 'تأكيد الميعاد',
                    style: getBoldStyle(
                      color: ColorManager.whiteColor,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
                onTap: () {
                  if (currentPage == 0 && canConfirm) {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                  else {
                    if(canSendRequest) {

                      AddNewPreviewRequestModel request = AddNewPreviewRequestModel(
                        propertyId: propertyId,
                        previewTime: state.selectedTime,
                        previewDate: DateFormat('yyyy-MM-dd', 'en').format(state.selectedDate!), // Use lowercase 'yyyy'
                        paymentMethod: state.currentPaymentMethod == 'بطاقة الائتمان' ? 'credit' : 'wallet',
                      );
                      context.read<PreviewPropertyCubit>().addPreviewTimeForSpecificProperty(request);
                    }
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
