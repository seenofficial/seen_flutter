import 'dart:developer';
import 'dart:io';

import 'package:enmaa/configuration/routers/app_routers.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/features/my_booking/my_booking_cubit.dart';
import 'package:enmaa/features/my_booking/my_booking_screen.dart';
import 'package:enmaa/features/my_profile/my_profile_screen.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:enmaa/features/real_estates/real_estates_DI.dart';
import 'package:enmaa/features/wallet/wallet_DI.dart';
import 'package:enmaa/features/wish_list/domain/use_cases/get_properties_wish_list_use_case.dart';
import 'package:enmaa/features/wish_list/domain/use_cases/remove_property_from_wish_list_use_case.dart';
import 'package:enmaa/features/wish_list/presentation/controller/wish_list_cubit.dart';
import 'package:enmaa/features/wish_list/wish_list_DI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configuration/managers/color_manager.dart';
import 'core/components/floating_nav_bar.dart';
import 'core/services/service_locator.dart';
import 'features/home_module/home_imports.dart';
import 'features/home_module/presentation/screens/home_screen.dart';
import 'features/wallet/presentation/controller/wallet_cubit.dart';
import 'features/wallet/presentation/screens/wallet_screen.dart';
import 'features/wish_list/domain/use_cases/add_new_property_to_wish_list_use_case.dart';
import 'features/wish_list/presentation/screens/wish_list_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key, required this.initialIndex, this.arguments});

  final int initialIndex;
  final dynamic arguments;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late PageController _pageController;
  late int currentIndex;


  DateTime? lastPressedTime;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return Navigator(
          key: AppRouters.homeNavigatorKey,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );
          },
        );
      case 1:
        return const MyBookingScreen();
      case 2:
        return WishListScreen();
      case 3:
        return BlocProvider(
          create: (context) {
            WalletDi().setup();

            return WalletCubit(
                ServiceLocator.getIt(),
                ServiceLocator.getIt(),
            )
              ..getWalletData() ..getTransactionHistoryData();
          },
          child: WalletScreen(),
        );
      case 4:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  bool _onWillPop() {
    final now = DateTime.now();
    if (lastPressedTime == null ||
        now.difference(lastPressedTime!) > const Duration(seconds: 5)) {
      lastPressedTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: ColorManager.primaryColor,
        content: Text('press back again to exit'),
        duration: const Duration(seconds: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
      ));
      return false;
    }
    return true;
  }

  List<FloatingNavBarItem> get items =>
      [
        FloatingNavBarItem(icon: AppAssets.homeIcon, text: 'الرئيسيه'),
        FloatingNavBarItem(
            icon: AppAssets.bookingIcon, text: 'حجوزاتي'),
        FloatingNavBarItem(
            icon: AppAssets.heartIcon,
            text: 'المفضله'),
        FloatingNavBarItem(
            icon: AppAssets.walletIcon,
            text: 'محفظتي'),
        FloatingNavBarItem(
            icon: AppAssets.personIcon, text: 'حسابي'),
      ];

  Widget _buildBottomNavBar() {
    return Localizations.override(
      context: context,
      child: FloatingBottomNavBar(
        items: items,
        currentIndex: currentIndex,
        onItemSelected: (index) {
          if (index == 0 && currentIndex == 0) {
            AppRouters.homeNavigatorKey.currentState?.popUntil((route) =>
            route.isFirst);
          } else {
            setState(() {
              currentIndex = index;
              _pageController.jumpToPage(index);
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyBookingCubit(),
        ),

        BlocProvider(
            create: (context) {
              RealEstatesDi().setup();

              if (ServiceLocator.getIt.isRegistered<RealEstateCubit>()) {
                final cubit = ServiceLocator.getIt<RealEstateCubit>();
                if (cubit.isClosed) {
                  ServiceLocator.getIt.unregister<RealEstateCubit>();
                }
              }

              if (!ServiceLocator.getIt.isRegistered<RealEstateCubit>()) {
                ServiceLocator.getIt.registerLazySingleton<RealEstateCubit>(
                      () =>
                      RealEstateCubit(
                        ServiceLocator.getIt(),
                        ServiceLocator.getIt(),
                      ),
                );
              }

              return ServiceLocator.getIt<RealEstateCubit>()
                ..fetchProperties();
            }
        ),
      ],
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, dynamic results) async {
          if (currentIndex == 0) {
            final bool shouldPop = _onWillPop();
            if (shouldPop) {
              exit(0);
            }
          } else {
            _pageController.jumpToPage(0);
          }
        },
        child: Scaffold(
          body: SafeArea(
            top: false,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) => _buildScreen(index),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          ),
          extendBody: true,
          bottomNavigationBar: _buildBottomNavBar(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
