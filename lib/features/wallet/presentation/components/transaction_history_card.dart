import 'package:enmaa/core/components/svg_image_component.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/features/wallet/domain/entities/transaction_history_entity.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/style_manager.dart';

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({super.key, required this.transactionHistoryEntity});

  final TransactionHistoryEntity transactionHistoryEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.scale(80),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: context.scale(32),
            height: context.scale(32),
            decoration: BoxDecoration(
              color: ColorManager.yellowColor ,
              shape: BoxShape.circle,
            ),
            child: SvgImageComponent(iconPath: AppAssets.sendIcon ,width: 16, height: 16,),
          ),
          SizedBox(width: context.scale(12),),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionHistoryEntity.title,
                style: getSemiBoldStyle(color: ColorManager.blackColor, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                transactionHistoryEntity.date,
                style: getSemiBoldStyle(color: ColorManager.grey2, fontSize: 14),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  transactionHistoryEntity.amount,
                  style: getBoldStyle(
                    color: transactionHistoryEntity.amount.contains("-")
                        ? ColorManager.redColor
                        : ColorManager.greenColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
