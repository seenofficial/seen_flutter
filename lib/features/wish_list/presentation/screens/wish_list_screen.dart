import 'package:enmaa/configuration/routers/app_routers.dart';
import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/wish_list/presentation/controller/wish_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../../core/screens/error_app_screen.dart';
import '../../../../core/screens/property_empty_screen.dart';
import '../../../home_module/presentation/components/real_state_card_component.dart';
import '../../favorite_imports.dart';
import '../components/wish_list_property_card.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Column(
        children: [
          const AppBarComponent(
            appBarTextMessage: 'المفضله',
            showNotificationIcon: false,
            showLocationIcon: false,
             centerText: true,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<WishListCubit>().getPropertyWishList();
              },
              child: BlocBuilder<WishListCubit, WishListState>(
                builder: (context, state) {
                  if (state.getPropertyWishListState.isLoaded) {
                    if (state.propertyWishList.isEmpty) {
                      return EmptyScreen (
                        alertText1: 'ليس لديك أي مفضلات حاليًا',
                        alertText2: 'استكشف العروض وأضف ما يعجبك إلى المفضلة بسهولة',
                        buttonText: 'استكشف العروض المتاحة',
                        onTap: (){
                          Navigator.pushNamed(context, RoutersNames.layoutScreen, arguments: 0);
                        },
                      ) ;
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: state.propertyWishList.length,
                      itemBuilder: (context, index) {
                        final wishListItem = state.propertyWishList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: WishListPropertyCard (
                            wishListId: wishListItem.id.toString(),
                            currentProperty: wishListItem.property!,
                          ),
                        );
                      },
                    );
                  } else if (state.getPropertyWishListState.isError) {
                    return ErrorAppScreen(
                      showActionButton: false,
                      showBackButton: false,
                    );
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
