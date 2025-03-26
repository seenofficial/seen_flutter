import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../../core/screens/error_app_screen.dart';
import '../../../../core/screens/property_empty_screen.dart';
import '../../../../core/utils/enums.dart';
import '../../../wish_list/favorite_imports.dart';
import '../../domain/entities/notification_entity.dart';
import '../components/notification_component.dart';
import '../controller/home_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, required this.numberOfNotifications});
  final int numberOfNotifications;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ServiceLocator.getIt<HomeBloc>(),
      child: Scaffold(
        backgroundColor: ColorManager.greyShade,
        body: Column(
          children: [
            AppBarComponent(
              appBarTextMessage: LocaleKeys.notificationsScreenTitle.tr(),
              homeBloc: ServiceLocator.getIt<HomeBloc>(),
              showNotificationIcon: false,
              showLocationIcon: false,
              centerText: true,
              showBackIcon: true,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ServiceLocator.getIt<HomeBloc>().add(GetNotifications());
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    switch (state.getNotificationsState) {
                      case RequestState.loading || RequestState.initial:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case RequestState.loaded:
                        return state.notifications.isEmpty
                            ? _buildEmptyNotifications()
                            : _buildNotificationsList(state.notifications);
                      case RequestState.error:
                        return ErrorAppScreen(
                          showActionButton: false,
                          showBackButton: false,
                          backgroundColor: Colors.grey.shade100,
                        );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyNotifications() {
    return EmptyScreen(
      alertText1: LocaleKeys.notificationsScreenNoNotifications.tr(),
      alertText2: LocaleKeys.notificationsScreenExploreOffers.tr(),
    );
  }

  Widget _buildNotificationsList(List<NotificationEntity> notifications) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: NotificationComponent(
            notification: notification,
            isRead: index + 1 > widget.numberOfNotifications ? false : true,
          ),
        );
      },
    );
  }
}