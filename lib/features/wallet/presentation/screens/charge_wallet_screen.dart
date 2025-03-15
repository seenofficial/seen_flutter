import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/screens/property_empty_screen.dart';
import '../../../home_module/home_imports.dart';
import '../../domain/entities/transaction_history_entity.dart';
import '../components/charge_screen_wallet_data_container.dart';
import '../components/transaction_history_card.dart';
import '../components/transaction_history_list.dart';
import '../components/wallet_data_container.dart';
import '../controller/wallet_cubit.dart';

class ChargeWalletScreen extends StatelessWidget {
  const ChargeWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ChargeScreenWalletDataContainer(),
          SizedBox(height: context.scale(12)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TransactionHistoryList(
              title: 'سجل المعاملات المالية',
            ),
          ),
        ],
      ),
    );
  }
}