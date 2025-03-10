import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/circular_icon_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../home_module/home_imports.dart';

class RealEstateDetailsHeaderActionsComponent extends StatelessWidget {
  const RealEstateDetailsHeaderActionsComponent({super.key});

  final double containerSize = 40;
  final double iconSize = 20;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircularIconButton(
          iconPath: AppAssets.backIcon,
          containerSize: context.scale(containerSize),
          iconSize: iconSize,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Row(
          children: [
            CircularIconButton(
              iconPath: AppAssets.shareIcon,
              containerSize: context.scale(containerSize),
              iconSize: context.scale(iconSize),
              onPressed: () {},
            ),
            SizedBox(width: context.scale(16)),
            BlocBuilder<RealEstateCubit, RealEstateState>(
              builder: (context, state) {
                bool isInWishlist = state.getPropertyDetailsState.isLoaded && state.propertyDetails!.isInWishlist;
                return CircularIconButton(
                  iconPath:isInWishlist? AppAssets.selectedHeartIcon: AppAssets.heartIcon,
                  containerSize: context.scale(containerSize),
                  iconSize: context.scale(iconSize),
                  onPressed: () {

                    /// todo : add or remove from wishlist
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
