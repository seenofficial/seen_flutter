import 'package:dio/dio.dart';
import 'package:enmaa/features/home_module/home_DI.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication_module/authentication_DI.dart';
import '../../features/real_estates/real_estates_DI.dart';
import 'dio_service.dart';


class ServiceLocator {
  static GetIt getIt = GetIt.instance;

  ServiceLocator._();
}

Future<void> setupServiceLocator() async {
  final sl = ServiceLocator.getIt;

  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioService>(() => DioService(dio: sl<Dio>()));


  await Future.wait([
    HomeDi().setup(),
    AuthenticationDi().setup(),
    //RealEstatesDi().setup(),
  ]);


}