import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/components/shimmer_component.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/screens/error_app_screen.dart';
import 'package:enmaa/core/screens/property_empty_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/core/translation/locale_keys.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../home_module/home_imports.dart';
import '../../domain/entities/transaction_history_entity.dart';
import '../components/transaction_history_card.dart';
import '../components/wallet_data_container.dart';
import '../controller/wallet_cubit.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.isEmpty ? LocaleKeys.transactionHistoryTitle.tr() : title,
          style: getBoldStyle(
            color: ColorManager.primaryColor,
            fontSize: FontSize.s18,
          ),
        ),
        SizedBox(height: context.scale(16)),
        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state.getTransactionHistoryDataState.isLoading) {
              return _buildShimmerList(context);
            } else if (state.getTransactionHistoryDataState.isLoaded) {
              final List<TransactionHistoryEntity> transactionHistory = state.transactions;
              if (transactionHistory.isEmpty) {
                return SizedBox(
                  height: context.scale(300),
                  child: EmptyScreen(
                    alertText1: LocaleKeys.transactionHistoryNoTransactions.tr(),
                    alertText2: LocaleKeys.transactionHistoryEmptyMessage.tr(),
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: transactionHistory.length,
                itemBuilder: (context, index) {
                  return TransactionHistoryCard(
                    transactionHistoryEntity: transactionHistory[index],
                  );
                },
              );
            } else {
              return SizedBox(
                height: context.scale(300),
                child: ErrorAppScreen(
                  showActionButton: false,
                  showBackButton: false,
                  backgroundColor: ColorManager.greyShade,
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildShimmerList(BuildContext context) {
    return SizedBox(
      height: context.scale(320),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            5,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ShimmerComponent(
                height: 80,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ),
    );
  }
}