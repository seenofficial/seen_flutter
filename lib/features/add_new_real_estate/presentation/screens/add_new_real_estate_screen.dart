import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/configuration/managers/style_manager.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/controller/add_new_real_estate_cubit.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/screens/add_new_real_estate_main_information_screen.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/core/components/app_bar_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
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
            _buildNavigationButtons(),
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

  Widget _buildNavigationButtons() {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: 32.0,
        top: 16.0,
      ),
      child: AnimatedSwitcher(
        duration: animationTime,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              axis: Axis.horizontal,
              child: child,
            ),
          );
        },
        child: _currentPage == 0
            ? SizedBox(
          key: const ValueKey<int>(0),
          width: double.infinity,
          height: context.scale(48),
          child: ElevatedButton(
            onPressed: () {
              _pageController.nextPage(
                duration: animationTime,
                curve: Curves.easeIn,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('التالي'),
          ),
        )
            : Row(
          key: const ValueKey<int>(1),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.scale(175),
              height: context.scale(48),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 1),
                      curve: Curves.easeInOutSine,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFD6D8DB),
                  foregroundColor: Color(0xFFD6D8DB),
                ),
                child: Text(
                  'السابق',
                  style: TextStyle(color: ColorManager.blackColor),
                ),
              ),
            ),
            AnimatedSize(
              duration: animationTime,
              curve: Curves.easeInOut,
              child: SizedBox(
                width: context.scale(175),
                height: context.scale(48),
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: animationTime,
                        curve: Curves.easeIn,
                      );
                    } else {
                      // Submit action here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_currentPage == 2 ? 'إرسال' : 'التالي'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}