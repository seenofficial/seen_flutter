import 'package:enmaa/features/preview_property/presentation/controller/preview_property_cubit.dart';
import '../../core/services/service_locator.dart';


class PreviewPropertyDi {
  final sl = ServiceLocator.getIt;

  Future<void> setup() async {

    _registerDataSources();
    _registerRepositories();
    _registerUseCases();
    _registerBlocs();


  }


  void _registerDataSources() {


  }

  void _registerRepositories() {

  }

  void _registerUseCases() {

  }
  void _registerBlocs() {





  }
}