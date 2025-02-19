import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/controller/add_new_real_estate_cubit.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/screens/add_new_real_estate_main_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/core/components/app_bar_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../components/add_new_real_estate_buttons.dart';
import 'add_new_real_estate_location_screen.dart';
import 'add_new_real_estate_price_screen.dart';

class AddNewRealEstateScreen extends StatefulWidget {
  const AddNewRealEstateScreen({super.key});

  @override
  _AddNewRealEstateScreenState createState() => _AddNewRealEstateScreenState();
}

class _AddNewRealEstateScreenState extends State<AddNewRealEstateScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNewRealEstateCubit(),
      child: Scaffold(
        backgroundColor: ColorManager.greyShade,
        body: Column(
          children: [
            AppBarComponent(
              appBarTextMessage: 'إضافة عقار',
              showNotificationIcon: false,
              showLocationIcon: false,
              showBackIcon: true,
              centerText: true,
            ),
            _buildPageIndicator(),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  AddNewRealEstateMainInformationScreen(),
                  AddNewRealEstatePriceScreen(),
                  AddNewRealEstateLocationScreen(),
                ],
              ),
            ),
            AddNewRealEstateButtons(
              pageController: _pageController,
              currentPage: _currentPage,
              animationTime: const Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }


  var animationTime = const Duration(milliseconds: 500);


  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          bool isActive = index <= _currentPage;
          return Column(
            children: [
              Text(
                index == 0
                    ? 'المعلومات الأساسية'
                    : index == 1
                    ? 'السعر والوصف'
                    : 'الموقع والمميزات',
                style: getBoldStyle(
                  color: isActive ? ColorManager.primaryColor : ColorManager
                      .blackColor,
                  fontSize: FontSize.s11,
                ),
              ),
              SizedBox(height: context.scale(8)),
              AnimatedContainer(
                duration: animationTime,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: context.scale(115.33),
                height: context.scale(4),
                decoration: BoxDecoration(
                  color: isActive ? ColorManager.primaryColor : Color(
                      0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }


}

