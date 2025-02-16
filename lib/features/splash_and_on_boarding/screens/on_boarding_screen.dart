import 'package:enmaa/configuration/managers/color_manager.dart';
import 'package:enmaa/core/constants/app_assets.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../configuration/managers/font_manager.dart';
import '../../../configuration/managers/style_manager.dart';
import '../../../configuration/routers/route_names.dart';
import '../../../core/components/button_app_component.dart';
import '../components/on_boarding_content_component.dart';
import '../models/on_boarding_mdoel.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnBoardingPage> _onBoardingPages = [
    OnBoardingPage(
      image: AppAssets.onBoarding1,
      title: 'ليس مجرد عقار.. بل اختيار لحياتك',
      description1: 'رحلتك للعثور على العقار المثالي تبدأ هنا..',
      description2: 'حيث نساعدك في كل خطوة لضمان اختيار يلبي تطلعاتك واحتياجاتك.',
    ),
    OnBoardingPage(
      image: AppAssets.onBoarding2,
      title: 'عقد إلكتروني يضمن حقوقك بكل ثقة',
      description1: 'نوفر لك عقدًا إلكترونيًا موثّقًا يحفظ حقوق جميع الأطراف لتتم عملية التملك أو الإيجار بكل شفافية وأمان.',
      description2: 'ثقتك هي أولويتنا!',
    ),
    OnBoardingPage(
      image: AppAssets.onBoarding3,
      title: 'معك في كل خطوة!',
      description1: 'إذا واجهت أي استفسار، فريق إنماء هنا لمساعدتك.',
      description2: 'عند اختيارك للعقار، نبقى على تواصل لضمان تجربة سلسة وآمنة.',
    ),
  ];

  void _navigateToNextPage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, RoutersNames.authenticationFlow);
    } else {
      Navigator.pushReplacementNamed(context, RoutersNames.authenticationFlow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onBoardingPages.length,
                    onPageChanged: (page) => setState(() => _currentPage = page),
                    itemBuilder: (context, index) => OnBoardingPageWidget(
                      page: _onBoardingPages[index],
                      currentPage: _currentPage,
                      totalPages: _onBoardingPages.length,
                    ),
                  ),
                ),
                _buildPageIndicator(),
                const SizedBox(height: 16),
                _buildNavigationButton(),
              ],
            ),
            _buildSkipButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _onBoardingPages.length,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? context.scale(10) : context.scale(6),
          height: _currentPage == index ? context.scale(10) : context.scale(6),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? ColorManager.primaryColor : ColorManager.primaryColor2,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ButtonAppComponent(
        width: double.infinity,
        height: 46,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(context.scale(20)),
        ),
        buttonContent: Center(
          child: Text(
            _currentPage == _onBoardingPages.length - 1 ? 'تسجيل الدخول' : 'التالي',
            style: getBoldStyle(
              color: ColorManager.whiteColor,
              fontSize: FontSize.s14,
            ),
          ),
        ),
        onTap: () {
          if (_currentPage == _onBoardingPages.length - 1) {
            _navigateToNextPage();
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          }
        },
      ),
    );
  }

  Widget _buildSkipButton() {
    return PositionedDirectional(
      top: context.scale(16),
      end: context.scale(16),
      child: Visibility(
        visible: _currentPage != _onBoardingPages.length - 1,
        child: GestureDetector(
          onTap: ()=> _navigateToNextPage(),
          child: Text(
            'تخطي',
            style: getMediumStyle(
              color: ColorManager.blackColor,
              fontSize: FontSize.s12,
            ),
          ),
        ),
      ),
    );
  }
}
