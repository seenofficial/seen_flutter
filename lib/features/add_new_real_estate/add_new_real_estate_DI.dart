import 'package:enmaa/features/add_new_real_estate/data/data_source/add_new_real_estate_remote_data_source.dart';
import 'package:enmaa/features/add_new_real_estate/data/repository/add_new_real_estate_repository.dart';
import 'package:enmaa/features/add_new_real_estate/domain/repository/base_add_new_real_estate_repository.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_apartment_use_case.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_building_use_case.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_new_land_use_case.dart';
import 'package:enmaa/features/add_new_real_estate/domain/use_cases/add_villa_use_case.dart';

import '../../core/services/service_locator.dart';


class AddNewRealEstateDi {
  final sl = ServiceLocator.getIt;

  Future<void> setup() async {

    _registerDataSources();
    _registerRepositories();
    _registerUseCases();


  }


  void _registerDataSources() {

    if(sl.isRegistered<BaseAddNewRealEstateDataSource>()) return;

    sl.registerLazySingleton<BaseAddNewRealEstateDataSource>(
          () => AddNewRealEstateRemoteDataSource(dioService: sl()),
    );
  }

  void _registerRepositories() {
    if(sl.isRegistered<BaseAddNewRealEstateRepository>()) return;

    sl.registerLazySingleton<BaseAddNewRealEstateRepository>(
          () => AddNewRealEstateRepository(baseAddNewRealEstateDataSource: sl(), ),
    );
  }

  void _registerUseCases() {

    if(sl.isRegistered<AddNewApartmentUseCase>()) return;

    sl.registerLazySingleton(
          () => AddNewApartmentUseCase (sl()),
    );
    sl.registerLazySingleton(
          () => AddVillaUseCase (sl()),
    );
    sl.registerLazySingleton(
          () => AddNewBuildingUseCase (sl()),
    );
    sl.registerLazySingleton(
          () => AddNewLandUseCase (sl()),
    );




  }
}