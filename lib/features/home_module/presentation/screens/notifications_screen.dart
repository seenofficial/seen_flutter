import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_bar_component.dart';
import '../../../../core/screens/error_app_screen.dart';
import '../../../../core/screens/property_empty_screen.dart';
import '../../../../core/utils/enums.dart';
import '../../../wish_list/favorite_imports.dart';
import '../../domain/entities/notification_entity.dart';
import '../components/notification_component.dart';
import '../controller/home_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key , required this.numberOfNotifications});
  final int numberOfNotifications ;

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
              appBarTextMessage: 'الإشعارات',
              homeBloc: ServiceLocator.getIt<HomeBloc>(),
              showNotificationIcon: false,
              showLocationIcon: false,
              centerText: true,
              showBackIcon: true,
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyNotifications() {
    return EmptyScreen(
      alertText1: 'لا توجد إشعارات ',
      alertText2: 'استكشف العروض وأضف ما يعجبك لإنشاء حجوزات جديدة',
    );
  }

  Widget _buildNotificationsList(List<NotificationEntity> notifications) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final notification = notifications[index];

        return NotificationComponent(
            notification: notification,
          isRead: index +1 > widget.numberOfNotifications ? false : true,
        );
      },
    );
  }
}

