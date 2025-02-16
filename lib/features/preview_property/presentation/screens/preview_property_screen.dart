import 'package:animate_do/animate_do.dart';
import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/preview_property/presentation/controller/preview_property_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/custom_snack_bar.dart';
import '../../../home_module/home_imports.dart';

class PreviewPropertyScreen extends StatelessWidget {
  const PreviewPropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBarComponent(
                appBarTextMessage: 'معاينة العقار',
                showNotificationIcon: false,
                showLocationIcon: false,
                showBackIcon: true,
                centerText: true,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.scale(16)),
                  child: SingleChildScrollView(
                    child: SafeArea(
                      top: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTitle(context),
                          SizedBox(height: context.scale(16)),
                          _buildDateSection(context),
                          SizedBox(height: context.scale(16)),
                          _buildTimeSection(context),
                          SizedBox(height: context.scale(24)),
                          _buildWarningMessages(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildBottomButtons(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'حدد تاريخ ووقت المعاينة',
      style: getBoldStyle(color: ColorManager.blackColor),
    );
  }

  Widget _buildDateSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التاريخ',
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s12,
          ),
        ),
        SizedBox(height: context.scale(10)),
        BlocBuilder<PreviewPropertyCubit, PreviewPropertyState>(
          builder: (context, state) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<PreviewPropertyCubit>().changePreviewDateVisibility();
                  },
                  child: Container(
                    height: context.scale(44),
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(context.scale(20)),
                      border: Border.all(
                        color: state.showPreviewDate ? ColorManager.primaryColor : ColorManager.greyShade,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                      child: Row(
                        children: [
                          SvgImageComponent(
                              iconPath: AppAssets.calendarIcon,
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: context.scale(8)),
                          Expanded(
                            child: Text(
                              state.selectedDate != null
                                  ? '${state.selectedDate!.day}/${state.selectedDate!.month}/${state.selectedDate!.year}'
                                  : 'اختر التاريخ',
                              style: state.selectedDate == null
                                  ? getRegularStyle(
                                color: ColorManager.grey2,
                                fontSize: FontSize.s12,
                              )
                                  : getSemiBoldStyle(
                                color: ColorManager.primaryColor,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                          Icon(
                            !state.showPreviewDate
                                ? Icons.arrow_drop_down_sharp
                                : Icons.arrow_drop_up_sharp,
                            color: ColorManager.grey2,
                            size: context.scale(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, -0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: state.showPreviewDate
                      ? FadeInDown(
                    duration: Duration(seconds: 1),
                    child: Container(
                      key: ValueKey<bool>(state.showPreviewDate),
                      margin: EdgeInsets.only(top: context.scale(8)),
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(context.scale(12)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.blackColor.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: SfCalendar(
                        view: CalendarView.month,
                        firstDayOfWeek: 7,
                        showNavigationArrow: true,
                        backgroundColor: ColorManager.whiteColor,
                        headerStyle: CalendarHeaderStyle(
                          textStyle: getBoldStyle(
                            color: ColorManager.primaryColor,
                            fontSize: FontSize.s14,
                          ),
                          backgroundColor: ColorManager.whiteColor,
                          textAlign: TextAlign.center,
                        ),
                        selectionDecoration: BoxDecoration(
                          color: ColorManager.primaryColor.withOpacity(0.3),
                          border: Border.all(
                            color: ColorManager.primaryColor,
                            width: 1,
                          ),
                          shape: BoxShape.circle,
                        ),
                        monthViewSettings: MonthViewSettings(
                          showTrailingAndLeadingDates: false,
                          dayFormat: 'EEE',
                          monthCellStyle: MonthCellStyle(
                            textStyle: getRegularStyle(
                              color: ColorManager.primaryColor,
                              fontSize: FontSize.s12,
                            ),
                            leadingDatesTextStyle: getRegularStyle(
                              color: ColorManager.primaryColor,
                              fontSize: FontSize.s12,
                            ),
                            trailingDatesTextStyle: getRegularStyle(
                              color: ColorManager.primaryColor,
                              fontSize: FontSize.s12,
                            ),
                            backgroundColor: ColorManager.whiteColor,
                          ),
                          navigationDirection: MonthNavigationDirection.horizontal,
                        ),
                        onSelectionChanged: (calendarSelectionDetails) {
                          context.read<PreviewPropertyCubit>().selectDate(
                            calendarSelectionDetails.date!,
                          );
                        },
                        minDate: DateTime.now(),
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الوقت',
          style: getBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s12,
          ),
        ),
        SizedBox(height: context.scale(8)),
        BlocBuilder<PreviewPropertyCubit, PreviewPropertyState>(
          builder: (context, state) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    context.read<PreviewPropertyCubit>().changePreviewTimeVisibility();
                  },
                  child: Container(
                    height: context.scale(44),
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(context.scale(20)),
                      border: Border.all(
                        color: state.showPreviewTime ? ColorManager.primaryColor : ColorManager.greyShade,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: context.scale(16)),
                      child: Row(
                        children: [
                          SvgImageComponent(
                            iconPath: AppAssets.clockIcon,
                            width: 16,
                            height: 16,
                          ),
                          SizedBox(width: context.scale(8)),
                          Expanded(
                            child: Text(
                              state.selectedTime != null
                                  ? state.selectedTime!.format(context)
                                  : 'اختر الوقت',
                              style: state.selectedTime == null
                                  ? getRegularStyle(
                                color: ColorManager.grey2,
                                fontSize: FontSize.s12,
                              )
                                  : getSemiBoldStyle(
                                color: ColorManager.primaryColor,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                          Icon(
                            !state.showPreviewTime
                                ? Icons.arrow_drop_down_sharp
                                : Icons.arrow_drop_up_sharp,
                            color: ColorManager.grey2,
                            size: context.scale(24),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(seconds: 1),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, -0.1),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: state.showPreviewTime
                      ? FadeInDown(
                    duration: Duration(seconds: 1),
                    child: Container(
                      key: ValueKey<bool>(state.showPreviewTime),
                      margin: EdgeInsets.only(top: context.scale(8)),
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        borderRadius: BorderRadius.circular(context.scale(12)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.blackColor.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          SizedBox(
                            height: context.scale(142),
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime newTime) {
                                final TimeOfDay selectedTime = TimeOfDay.fromDateTime(newTime);
                                context.read<PreviewPropertyCubit>().selectTime(selectedTime);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      : SizedBox.shrink(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildWarningMessages(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgImageComponent(
              iconPath: AppAssets.warningIcon,
              width: 16,
              height: 16,
            ),
            SizedBox(width: context.scale(8)),
            Expanded(
              child: Text(
                'سيكون هناك مستشار عقاري معك من البداية حتى إتمام المعاينة لضمان تجربة سلسة وآمنة.',
                maxLines: 2,
                style: getMediumStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.scale(12)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgImageComponent(
              iconPath: AppAssets.warningIcon,
              width: 16,
              height: 16,
            ),
            SizedBox(width: context.scale(8)),
            Expanded(
              child: Text(
                'تتم جميع المعاينات مباشرة من خلال مكتب إنماء لضمان الشفافية والمصداقية في كل خطوة.',
                maxLines: 2,
                style: getMediumStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
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
                'إلغاء',
                style: getMediumStyle(
                  color: ColorManager.blackColor,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          BlocBuilder<PreviewPropertyCubit, PreviewPropertyState>(
            builder: (context, state) {
              final bool canConfirm = state.selectedDate != null && state.selectedTime != null;
              return ButtonAppComponent(
                width: 171,
                height: 46,
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: canConfirm ? ColorManager.primaryColor : ColorManager.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(context.scale(24)),
                ),
                buttonContent: Center(
                  child: Text(
                    'تأكيد الميعاد',
                    style: getBoldStyle(
                      color: ColorManager.whiteColor,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
                onTap: () {

                  if (canConfirm) {

                    Navigator.of(context).pop(true);

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