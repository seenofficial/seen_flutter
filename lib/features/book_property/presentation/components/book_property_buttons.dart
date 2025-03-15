import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/book_property/presentation/controller/book_property_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../configuration/managers/color_manager.dart';
import '../../../home_module/home_imports.dart';

class BookPropertyButtons extends StatelessWidget {
  final PageController pageController;
  final int currentPage;
  final Duration animationTime;
  final String propertyID;

  const BookPropertyButtons({
    super.key,
    required this.pageController,
    required this.currentPage,
    required this.animationTime,
    required this.propertyID,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookPropertyCubit, BookPropertyState>(
      listener: (context, state) {
        if (state.bookPropertyState.isLoaded &&
            state.bookPropertyResponse != null &&
            state.bookPropertyResponse!.gatewayUrl.isNotEmpty) {
          Navigator.pop(context);
          _launchPaymentUrl(state.bookPropertyResponse!.gatewayUrl);
        }
      },
      builder: (context, state) {
        bool getBookingData = state.getPropertySaleDetailsState.isLoaded;
        bool isLoading = state.bookPropertyState.isLoading;
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
                  if (currentPage == 0) {
                    if (getBookingData) {
                      pageController.nextPage(
                        duration: animationTime,
                        curve: Curves.easeIn,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: getBookingData
                      ? ColorManager.primaryColor
                      : ColorManager.grey2,
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
                      onPressed: isLoading
                          ? null
                          : () {
                        if (currentPage < 2) {
                          bool validImage = context
                              .read<BookPropertyCubit>()
                              .validateImages();

                          if (validImage) {
                            pageController.nextPage(
                              duration: animationTime,
                              curve: Curves.easeIn,
                            );
                          }
                        } else {
                          context
                              .read<BookPropertyCubit>()
                              .bookProperty(propertyID);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: isLoading
                          ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : Text(currentPage == 2 ? 'إرسال' : 'التالي'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to launch the payment URL
  Future<void> _launchPaymentUrl(String url) async {
    if (url.isEmpty) return;

    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching payment URL: $e');
    }
  }
}