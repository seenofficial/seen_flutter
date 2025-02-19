import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../controller/add_new_real_estate_cubit.dart';

class AddNewRealEstateButtons extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final Duration animationTime;

  const AddNewRealEstateButtons({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.animationTime,
  });

  @override
  Widget build(BuildContext context) {
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
        child: currentPage == 0
            ? SizedBox(
          key: const ValueKey<int>(0),
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (context.read<AddNewRealEstateCubit>().formKey.currentState!.validate()) {
                pageController.nextPage(
                  duration: animationTime,
                  curve: Curves.easeIn,
                );
              }
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
              width: 175,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage > 0) {
                    pageController.previousPage(
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
                width: 175,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentPage < 2) {
                      if (context.read<AddNewRealEstateCubit>().priceForm.currentState!.validate()) {
                        pageController.nextPage(
                          duration: animationTime,
                          curve: Curves.easeIn,
                        );
                      }
                    } else {
                      if (context.read<AddNewRealEstateCubit>().locationForm.currentState!.validate()) {

                          /// send request to add new real estate


                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(currentPage == 2 ? 'إرسال' : 'التالي'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}