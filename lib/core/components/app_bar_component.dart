import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/circular_icon_button.dart';
import 'package:enmaa/core/components/custom_bottom_sheet.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../configuration/managers/color_manager.dart';
import '../../configuration/routers/route_names.dart';
import '../../features/home_module/home_imports.dart';
import 'package:flutter/material.dart';

import '../../features/home_module/presentation/controller/home_bloc.dart';
import '../screens/select_location_screen.dart';
import '../utils/enums.dart';
import 'need_to_login_component.dart';

class AppBarComponent extends StatefulWidget {
  const AppBarComponent({
    super.key,
    required this.appBarTextMessage,
    this.showNotificationIcon = true,
    this.showLocationIcon = true,
    this.showBackIcon = false,
    this.centerText = false,
    this.homeBloc,
  });

  final String appBarTextMessage;
  final bool showNotificationIcon;
  final bool showLocationIcon;
  final bool showBackIcon;
  final bool centerText;
  final HomeBloc? homeBloc;
  @override
  State<AppBarComponent> createState() => _AppBarComponentState();
}

class _AppBarComponentState extends State<AppBarComponent> {
  String? userName;
  String? numberOfNotifications;
  bool hasNewNotifications = false;

  late SharedPreferences pref;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('full_name');
      numberOfNotifications = pref.getString('notifications_count');
    });

    _checkForNewNotifications();
  }

  void _checkForNewNotifications() {
    if (widget.homeBloc != null) {
      final currentNotificationsCount =
          widget.homeBloc!.state.notifications.length;
      final savedCount = int.tryParse(numberOfNotifications ?? '0') ?? 0;

      if (currentNotificationsCount > savedCount) {
        setState(() {
          hasNewNotifications = true;
        });
      }
    }
  }

  void _updateNotificationsCount() {
    if (widget.homeBloc != null) {
      final currentCount =
          widget.homeBloc!.state.notifications.length.toString();
      pref.setString('notifications_count', currentCount);
      setState(() {
        numberOfNotifications = currentCount;
        hasNewNotifications = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(110),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(context.scale(16)),
          bottomRight: Radius.circular(context.scale(16)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (widget.showBackIcon && widget.centerText)
            Padding(
              padding: EdgeInsets.all(context.scale(16)),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircularIconButton(
                  containerSize: context.scale(32),
                  iconPath: AppAssets.backIcon,
                  backgroundColor: ColorManager.greyShade,
                ),
              ),
            )
          else if (widget.centerText)
            SizedBox(width: context.scale(64)),
          if (widget.centerText)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!widget.showBackIcon) const SizedBox(width: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: context.scale(16)),
                    child: Text(
                      widget.appBarTextMessage,
                      style: getBoldStyle(color: ColorManager.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            )
          else if (userName != null)
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(context.scale(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'أهلا  ${userName}، ',
                      style: getBoldStyle(color: ColorManager.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.appBarTextMessage,
                      style: getLightStyle(color: ColorManager.blackColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          if (userName == null)
            Visibility(
              visible: !widget.centerText,
              child: Expanded(
                child: Padding(
                  padding: EdgeInsets.all(context.scale(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'مرحباً بك، ',
                        style: getBoldStyle(color: ColorManager.blackColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed(
                                  RoutersNames.authenticationFlow);
                        },
                        child: Text(
                          'أنشئ حساباً لتحصل علي المميزات',
                          style: getUnderlineRegularStyle(
                              color: ColorManager.grey, fontSize: FontSize.s14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (widget.showLocationIcon)
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: context.scale(16),
                    bottom: context.scale(16),
                  ),
                  child: InkWell(
                    onTap: () {
                      if (isAuth) {
                        _showLocationPickerBottomSheet(
                            context, widget.homeBloc!);
                      } else {
                        needToLoginSnackBar();
                      }
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final String location = state.selectedCityName.isEmpty
                            ? 'الموقع'
                            : state.selectedCityName;
                        final textPainter = TextPainter(
                          text: TextSpan(
                            text: location,
                            style: getRegularStyle(
                              color: ColorManager.primaryColor,
                              fontSize: FontSize.s10,
                            ),
                          ),
                          maxLines: 1,
                          textDirection: TextDirection.rtl,
                        )..layout();

                        final textWidth = textPainter.width;
                        final containerWidth = textWidth.clamp(
                            context.scale(80), context.scale(120));

                        return Container(
                          height: context.scale(32),
                          width: containerWidth.toDouble(),
                          decoration: BoxDecoration(
                            color: ColorManager.greyShade,
                            borderRadius:
                                BorderRadius.circular(context.scale(16)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    location,
                                    overflow: TextOverflow.ellipsis,
                                    style: getRegularStyle(
                                      color: ColorManager.primaryColor,
                                      fontSize: FontSize.s10,
                                    ),
                                  ),
                                ),
                                SizedBox(width: context.scale(8)),
                                SvgPicture.asset(
                                  AppAssets.locationIcon,
                                  width: context.scale(16),
                                  height: context.scale(16),
                                  color: ColorManager.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          if (widget.showNotificationIcon)
            BlocListener<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state.getNotificationsState == RequestState.loaded) {
                  _checkForNewNotifications();
                }
              },
              child: Padding(
                padding: EdgeInsets.all(context.scale(16)),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(RoutersNames.notificationsScreen,
                            arguments: int.parse(numberOfNotifications ?? '0'))
                        .then((_) {
                      _updateNotificationsCount();
                    });
                  },
                  child: Stack(
                    children: [
                      CircularIconButton(
                        containerSize: context.scale(32),
                        iconPath: AppAssets.notificationIcon,
                        backgroundColor: ColorManager.greyShade,
                      ),
                      if (hasNewNotifications)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: context.scale(10),
                            height: context.scale(10),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: ColorManager.whiteColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
          else if (widget.centerText)
            SizedBox(width: context.scale(64)),
        ],
      ),
    );
  }
}

void _showLocationPickerBottomSheet(BuildContext context, HomeBloc homeBloc) {
  final rootContext = Navigator.of(context, rootNavigator: true).context;

  showModalBottomSheet(
    context: rootContext,
    backgroundColor: ColorManager.greyShade,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: homeBloc,
        child: CustomBottomSheet(
          widget: SelectLocationScreen(),
          headerText: 'حدد موقعك',
        ),
      );
    },
  );
}
