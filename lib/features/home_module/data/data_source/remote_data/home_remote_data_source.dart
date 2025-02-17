import 'package:dio/dio.dart';
import 'package:enmaa/features/home_module/data/models/app_service_model.dart';
import 'package:enmaa/features/home_module/data/models/banner_model.dart';

import '../../../../../core/constants/api_constants.dart';
import '../../../../../core/entites/image_entity.dart';
import '../../../../../core/services/dio_service.dart';

abstract class BaseHomeRemoteData {
  Future<List<ImageEntity>> getBanners();
  Future<List<AppServiceModel>> getAppServicesData();

}

class HomeRemoteDataSource extends BaseHomeRemoteData {
  DioService dioService;

  HomeRemoteDataSource({required this.dioService});

  @override
  Future<List<ImageEntity>> getBanners()async {
    /*final response = await dioService.get(
      url: "",
    );

    List<dynamic> jsonResponse = response.data['resource'] ?? [];

    List<BannerModel> banners = jsonResponse.map((banner) {
      return BannerModel.fromJson(banner);
    }).toList();*/

    final List<ImageEntity> banners = [
      ImageEntity( isMain: false, id: 2 , image: 'https://s3-alpha-sig.figma.com/img/12f6/28d4/040c58f24701dcdcebb5857e65845b65?Expires=1740960000&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=S2GsRnx5~12DKX6jA-EScpaqZ1g5zlum0upKLckhllMTrYfJ1j2iW7TQ8l9Fk~qJQtyJ9PgmP~c~-3xvqcVVeDszsU404TdtC8bPrZNtirDNVtrbNDIqSaH2Y5TKx0YgPzc2FZLtZ3DxmMPbl8CHPVUxf4vSVWawzjdC1Qzq~xdnGEdGHpaOuYlP~ZI1ST~6OkLxvprtOijKRjwnvF02sT-EcetZZp3SttLewaeDQHjopUavBU1aECHi0i5~3GA8-iladOLk2xc8JYOKHiuH6VxQMThMMbtYnDiQxb-4Y3J43ZEqPzGW2I1Miud0xo193Niy5XtCevamYaPqjXhoSw__'),
      ImageEntity(image: 'https://www.princehotels.com/wp-content/uploads/2019/05/hotel3.jpg', isMain: true, id: 1),
      ImageEntity(image: 'https://www.princehotels.com/wp-content/uploads/2024/12/spgr-benefit-plan_500x500.jpg', isMain: false, id: 2),
      ImageEntity( isMain: false, id: 1 , image: 'https://media.cntraveller.com/photos/6411b4b17e087c30d74222bc/master/w_1920%2Cc_limit/InterContinental%2520Danang%2520Sun%2520Peninsula%2520Resort-mar23-pr-global.jpg'),
    ];

    await Future.delayed(const Duration(seconds: 3), () {});

    return banners;
  }

  @override
  Future<List<AppServiceModel>> getAppServicesData() async {
    final response = await dioService.get(
      url: "https://vicious-katleen-inmaa-611bcf31.koyeb.app/api/core/services/",
    );

    final List<Map<String, dynamic>> dataList =
    (response.data as List).cast<Map<String, dynamic>>();

    List<AppServiceModel> appServices = dataList.map((service) {
      return AppServiceModel.fromJson(service);
    }).toList();

    return appServices;
  }

}