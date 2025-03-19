import 'dart:developer';

import 'package:enmaa/core/components/need_to_login_component.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:enmaa/features/wish_list/presentation/controller/wish_list_cubit.dart';
import 'package:enmaa/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/circular_icon_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../home_module/home_imports.dart';
import '../../../wish_list/domain/entities/property_wish_list_entity.dart';
import '../../../wish_list/wish_list_DI.dart';

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
            Visibility(
              visible: false,
              child: CircularIconButton(
                iconPath: AppAssets.shareIcon,
                containerSize: context.scale(containerSize),
                iconSize: context.scale(iconSize),
                onPressed: () {},
              ),
            ),
            SizedBox(width: context.scale(16)),
            BlocBuilder<RealEstateCubit, RealEstateState>(
              builder: (context, state) {
                bool isInWishlist = state.getPropertyDetailsState.isLoaded &&
                    state.propertyDetails!.isInWishlist;
                return CircularIconButton(
                  iconPath: isInWishlist
                      ? AppAssets.selectedHeartIcon
                      : AppAssets.heartIcon,
                  containerSize: context.scale(containerSize),
                  iconSize: context.scale(iconSize),
                  onPressed: () {

                    if(isAuth){
                      if(state.getPropertyDetailsState.isLoaded){
                        if(isInWishlist){

                          context.read<RealEstateCubit>().removePropertyFromWishList(state.propertyDetails!.id.toString());
                          context.read<WishListCubit>().removePropertyFromWishList(state.propertyDetails!.id.toString());

                        }
                        else {

                          context.read<RealEstateCubit>().addPropertyToWishList(state.propertyDetails!.id.toString());
                          context.read<WishListCubit>().addPropertyToWishList(state.propertyDetails!.id.toString());

                        }
    }
                    }
                    else {
                      needToLoginSnackBar();
                    }
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
