import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/shimmer_component.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/screens/property_empty_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../home_module/home_imports.dart';
import '../../domain/entities/transaction_history_entity.dart';
import '../components/transaction_history_card.dart';
import '../components/transaction_history_list.dart';
import '../components/wallet_data_container.dart';
import '../controller/wallet_cubit.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Column(
        children: [
          const AppBarComponent(
            appBarTextMessage: 'محفظتي',
            showNotificationIcon: false,
            showLocationIcon: false,
            centerText: true,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WalletDataContainer(),

                  SizedBox(height: context.scale(12)),


                  TransactionHistoryList()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
