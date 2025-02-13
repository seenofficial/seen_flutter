import 'package:enmaa/features/home_module/data/repository/home_repository.dart';
import 'package:enmaa/features/home_module/domain/repository/base_home_repository.dart';
import 'package:enmaa/features/home_module/domain/use_cases/get_app_services_use_case.dart';
import 'package:enmaa/features/home_module/domain/use_cases/get_banners_use_case.dart';
import 'package:enmaa/features/home_module/presentation/controller/home_bloc.dart';

import '../../core/services/service_locator.dart';
import 'data/data_source/remote_data/home_remote_data_source.dart';

class HomeDi {
  final sl = ServiceLocator.getIt;

  Future<void> setup() async {

    _registerRemoteDataSource();
    _registerRepositories();
    _registerUseCases();


    sl.registerLazySingleton<HomeBloc>(
          () => HomeBloc(
        sl<GetBannersUseCase>(),
        sl<GetAppServicesUseCase>(),
      ),
    );


  }


  void _registerRemoteDataSource() {
    sl.registerLazySingleton<BaseHomeRemoteData>(
          () => HomeRemoteDataSource(dioService: sl()),
    );
  }

  void _registerRepositories() {
    sl.registerLazySingleton<BaseHomeRepository>(
          () => HomeRepository(baseHomeRemoteData: sl()),
    );
  }

  void _registerUseCases() {
    sl.registerLazySingleton(
          () => GetBannersUseCase(sl()),
    );
    sl.registerLazySingleton(
          () => GetAppServicesUseCase(sl()),
    );

  }
}