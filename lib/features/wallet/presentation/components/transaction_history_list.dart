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
import '../components/wallet_data_container.dart';
import '../controller/wallet_cubit.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key , this.title = 'سجل المعاملات'});

  final String title ;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getBoldStyle(
              color: ColorManager.primaryColor,
              fontSize: FontSize.s18),
        ),

        SizedBox(height: context.scale(16)),

        BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {

            if (state.getTransactionHistoryDataState.isLoading) {
              return _buildShimmerList();
            } else if (state.getTransactionHistoryDataState.isLoaded) {
              final List<TransactionHistoryEntity> transactionHistory =
                  state.transactions;
              if (transactionHistory.isEmpty) {
                return Expanded(child: EmptyScreen(alertText1: 'لا توجد معاملات حتى الآن', alertText2: 'عند إجراء أي معاملة، ستظهر هنا فورًا.',  ));
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
              return Center(
                child: Text(
                  "فشل في جلب البيانات",
                  style: getMediumStyle(
                      color: ColorManager.redColor, fontSize: FontSize.s16),
                ),
              );
            }
          },
        ),
      ],
    );

  }

  Widget _buildShimmerList() {
    return Expanded(
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
