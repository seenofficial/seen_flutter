import 'package:enmaa/core/extensions/booking_status_extension.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/core/utils/enums.dart';

import '../../../../../../configuration/managers/color_manager.dart';


class UserPropertiesTabBar extends StatelessWidget {
  final TabController tabController;
  final List<BookingStatus> tabStatuses;
  final Function(int) onTabChanged;

  const UserPropertiesTabBar({
    super.key,
    required this.tabController,
    required this.tabStatuses,
    required this.onTabChanged,
  });

  Color _getColorForStatus(BookingStatus status) {
    switch (status) {
      case BookingStatus.available:
        return ColorManager.greenColor;
      case BookingStatus.reserved:
        return ColorManager.grey2;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: context.scale(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: TabBar(
          controller: tabController,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: _getColorForStatus(tabStatuses[tabController.index]),
          ),
          indicatorPadding: const EdgeInsets.all(6),
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: ColorManager.whiteColor,
          unselectedLabelColor: ColorManager.blackColor,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,

          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: onTabChanged,
          tabs: tabStatuses.map((status) {
            return Tab(
              child: Container(
                width: context.scale(103),
                height: context.scale(36),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    status.getName,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}