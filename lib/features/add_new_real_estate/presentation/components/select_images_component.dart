import 'package:enmaa/core/extensions/request_states_extension.dart';
import 'package:enmaa/features/add_new_real_estate/presentation/controller/add_new_real_estate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/font_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import 'dashed_border_container.dart';
import 'form_widget_component.dart';

class SelectImagesComponent extends StatefulWidget {
  const SelectImagesComponent({super.key});

  @override
  State<SelectImagesComponent> createState() => _SelectImagesComponentState();
}

class _SelectImagesComponentState extends State<SelectImagesComponent> {
  late AddNewRealEstateCubit addNewRealEstateCubit;

  @override
  void initState() {
    addNewRealEstateCubit = context.read<AddNewRealEstateCubit>();
    // Clear any previously selected images
    for (int i = 0; i < addNewRealEstateCubit.state.selectedImages.length; i++) {
      addNewRealEstateCubit.removeImage(i);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormWidgetComponent(
      label: 'إضافه صور العقار ',
      content: BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(
        builder: (context, state) {
          final selectedImages = state.selectedImages;

          final isLoading = state.selectImagesState.isLoading; // Ensure your state contains this flag

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgImageComponent(
                    iconPath: AppAssets.warningIcon,
                    width: 16,
                    height: 16,
                  ),
                  SizedBox(width: context.scale(8)),
                  Expanded(
                    child: Text(
                      'ستكون الصورة الأولى هي الصورة الرئيسية (الكفر).',
                      maxLines: 2,
                      style: getMediumStyle(
                        color: ColorManager.grey,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.scale(18)),

              if (selectedImages.isEmpty && !isLoading)
                BlocBuilder<AddNewRealEstateCubit, AddNewRealEstateState>(
                  builder: (context, state) {
                    final bool isImageSelected = state.validateImages;
                    return InkWell(
                      onTap: addNewRealEstateCubit.selectImages,
                      child: DottedBorderContainer(
                        width: 358,
                        height: 108,
                        borderRadius: 12,
                        borderColor: isImageSelected ? ColorManager.grey3 : Colors.red,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgImageComponent(
                              iconPath: AppAssets.folderIcon,
                              width: 16,
                              height: 16,
                            ),
                            SizedBox(width: context.scale(8)),
                            Text(
                              'قم برفع صور واضحة للعقار لإبراز مميزاته\nبحد أقصى 5MB لكل صورة',
                              textAlign: TextAlign.center,
                              style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

              if (isLoading)
                _buildShimmerGrid(context)
              else if (selectedImages.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: context.scale(8)),
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: selectedImages.length < 5
                        ? selectedImages.length + 1
                        : selectedImages.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 12,
                      childAspectRatio: 171 / 124,
                    ),
                    itemBuilder: (context, index) {
                       if (index == selectedImages.length && selectedImages.length < 5) {
                        return GestureDetector(
                          onTap: addNewRealEstateCubit.selectImages,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: ColorManager.grey3,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: ColorManager.primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 32,
                                    color: ColorManager.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                       return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: index == 0 ? Colors.blue : Colors.transparent,
                                width: index == 0 ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(21),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                selectedImages[index],
                                width: context.scale(171),
                                height: context.scale(124),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Delete icon
                          PositionedDirectional(
                            top: context.scale(8),
                            end: context.scale(12),
                            child: GestureDetector(
                              onTap: () => addNewRealEstateCubit.removeImage(index),
                              child: Container(
                                width: context.scale(24),
                                height: context.scale(24),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: ColorManager.blackColor,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShimmerGrid(BuildContext context) {
     return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 12,
        childAspectRatio: 171 / 124,
      ),
      itemBuilder: (context, index) {
        return Container(
          width: context.scale(171),
          height: context.scale(124),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }
}
