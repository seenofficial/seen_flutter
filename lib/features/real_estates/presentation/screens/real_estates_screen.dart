import 'package:easy_localization/easy_localization.dart';
import 'package:enmaa/configuration/managers/font_manager.dart';
import 'package:enmaa/core/components/custom_bottom_sheet.dart';
import 'package:enmaa/core/extensions/context_extension.dart';
import 'package:enmaa/core/extensions/operation_type_property_extension.dart';
import 'package:enmaa/core/extensions/property_operation_type_extension.dart';
import 'package:enmaa/core/screens/error_app_screen.dart';
import 'package:enmaa/core/services/service_locator.dart';
import 'package:enmaa/features/real_estates/presentation/controller/filter_properties_controller/filter_property_cubit.dart';
import 'package:enmaa/features/real_estates/presentation/controller/real_estate_cubit.dart';
import 'package:enmaa/features/real_estates/presentation/screens/real_estate_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../configuration/managers/color_manager.dart';
import '../../../../configuration/managers/style_manager.dart';
import '../../../../configuration/routers/route_names.dart';
import '../../../../core/components/app_bar_component.dart';
import '../../../../core/components/app_text_field.dart';
import '../../../../core/components/button_app_component.dart';
import '../../../../core/components/card_listing_shimmer.dart';
import '../../../../core/components/custom_snack_bar.dart';
import '../../../../core/components/custom_tab.dart';
import '../../../../core/components/need_to_login_component.dart';
import '../../../../core/components/svg_image_component.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/screens/property_empty_screen.dart';
import '../../../../core/translation/locale_keys.dart';
import '../../../../core/utils/enums.dart';
import '../../../../main.dart';
import '../../../home_module/presentation/components/real_state_card_component.dart';
import '../../../home_module/presentation/components/services_list_shimmer.dart';
import '../../../home_module/presentation/controller/home_bloc.dart';
import '../../../main_services_layout/main_service_layout_screen.dart';
import '../../domain/entities/base_property_entity.dart';

class RealStateScreen extends StatefulWidget {
  const RealStateScreen({super.key});

  @override
  State<RealStateScreen> createState() => _RealStateScreenState();
}

class _RealStateScreenState extends State<RealStateScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _saleScrollController = ScrollController();
  final ScrollController _rentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RealEstateCubit>().loadTabData(PropertyOperationType.forSale);
    });

    _setupScrollControllers();
  }

  void _setupScrollControllers() {
    _saleScrollController.addListener(() {
      if (_saleScrollController.position.pixels >=
          _saleScrollController.position.maxScrollExtent - 200) {
        Map<String , dynamic > ? filterData ;
       /* if(context.read<FilterPropertyCubit>().state.currentPropertyOperationType.isForSale){
          filterData = context.read<FilterPropertyCubit>().prepareDataForApi();
        }*/
        context.read<RealEstateCubit>().loadMoreProperties(PropertyOperationType.forSale ,filters: filterData);
      }
    });

    _rentScrollController.addListener(() {
      if (_rentScrollController.position.pixels >=
          _rentScrollController.position.maxScrollExtent - 200) {
        Map<String , dynamic >? filterData ;
        /*if(context.read<FilterPropertyCubit>().state.currentPropertyOperationType.isForRent){
          filterData = context.read<FilterPropertyCubit>().prepareDataForApi();
        }*/
        context.read<RealEstateCubit>().loadMoreProperties(PropertyOperationType.forRent , filters: filterData);
      }
    });
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging || _tabController.index != _tabController.previousIndex) {
      setState(() {
        final PropertyOperationType type = _tabController.index == 0
            ? PropertyOperationType.forSale
            : PropertyOperationType.forRent;

        context.read<FilterPropertyCubit>().changePropertyOperationType(type);
        context.read<RealEstateCubit>().loadTabData(type);
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _saleScrollController.dispose();
    _rentScrollController.dispose();
    super.dispose();
  }

  void _openFilterBottomSheet() {
    final rootContext = Navigator.of(context, rootNavigator: true).context;
    showModalBottomSheet(
      context: rootContext,
      backgroundColor: ColorManager.greyShade,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return CustomBottomSheet(
          widget: BlocProvider.value(
            value: ServiceLocator.getIt<RealEstateCubit>(),
            child: RealEstateFilterScreen(),
          ),
          headerText: "التصفية",
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.greyShade,
      body: Column(
        children: [
          AppBarComponent(
            appBarTextMessage: 'اختر العقار المثالي لك بسهولة',
            homeBloc: context.read<HomeBloc>(),
          ),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  onTap: _openFilterBottomSheet,
                  width: context.scale(235),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scale(16),
                    vertical: context.scale(8),
                  ),
                  hintText: 'ابحث عن كل ما تريد معرفته ...',
                  prefixIcon:
                  Icon(Icons.search, color: ColorManager.blackColor),
                ),
              ),
              ButtonAppComponent(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                width: context.scale(111),
                onTap: () {
                  if(isAuth) {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(RoutersNames.addNewRealEstateScreen);
                  }
                  else {
                    needToLoginSnackBar();
                  }
                },
                buttonContent: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgImageComponent(
                      iconPath: AppAssets.plusIcon,
                      width: 16,
                      height: 16,
                    ),
                    Text(
                      'أضف عقارك',
                      style: getBoldStyle(
                          color: ColorManager.whiteColor,
                          fontSize: FontSize.s12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TabBar(
            padding: EdgeInsets.symmetric(
              horizontal: context.scale(8),
              vertical: context.scale(6),
            ),
            controller: _tabController,
            indicator: const BoxDecoration(color: Colors.transparent),
            dividerColor: Colors.transparent,
            tabs: [
              CustomTab(
                text: 'للبيع ',
                isSelected: _tabController.index == 0,
              ),
              CustomTab(
                text: 'للإيجار ',
                isSelected: _tabController.index == 1,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSaleTab(),
                _buildRentTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaleTab() {
    return BlocBuilder<RealEstateCubit, RealEstateState>(
      builder: (context, state) {
        return _buildPropertyList(
          state.getPropertiesSaleState,
          state.saleProperties,
          state.getPropertiesSaleError,
          state.hasMoreSaleProperties,
          PropertyOperationType.forSale,
          _saleScrollController,
        );
      },
    );
  }

  Widget _buildRentTab() {
    return BlocBuilder<RealEstateCubit, RealEstateState>(
      builder: (context, state) {
        return _buildPropertyList(
          state.getPropertiesRentState,
          state.rentProperties,
          state.getPropertiesRentError,
          state.hasMoreRentProperties,
          PropertyOperationType.forRent,
          _rentScrollController,
        );
      },
    );
  }

  Widget _buildPropertyList(
      RequestState state,
      List<PropertyEntity> properties,
      String errorMessage,
      bool hasMore,
      PropertyOperationType type,
      ScrollController scrollController,
      ) {
    if (state == RequestState.loading && properties.isEmpty) {
      return CardShimmerList(
        scrollDirection: Axis.vertical,
        cardHeight: context.scale(282),
        cardWidth: context.screenWidth,
        numberOfCards: 3,
      );
    } else if (state == RequestState.error && properties.isEmpty) {
      return ErrorAppScreen(
        showBackButton: false,
        showActionButton: false,
        backgroundColor: ColorManager.greyShade,
      );
    } else if (properties.isEmpty) {
      return EmptyScreen(
        alertText1: 'لم تجد العقار المناسب؟ ',
        alertText2: 'تواصل مع مكتب إنماء للحصول على أفضل الخيارات. سنساعدك في العثور على العقار المناسب لك!',
        buttonText: 'تواصل معنا',
        onTap: () async {
          final Uri url = Uri.parse('https://github.com/AmrAbdElHamed26');

          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            CustomSnackBar.show(
              context: context,
              message: 'حدث خطأ أثناء فتح الرابط',
              type: SnackBarType.error,
            );
          }
        },
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<RealEstateCubit>().fetchProperties(
          operationType: type,
          refresh: true,
        );
      },
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount: properties.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == properties.length) {
            return CardListingShimmer(
              width: context.screenWidth,
              height: context.scale(282),
            );
          }

          final property = properties[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RealStateCardComponent(
              width: MediaQuery.of(context).size.width,
              height: context.scale(290),
              currentProperty: property,
            ),
          );
        },
      ),
    );
  }
}