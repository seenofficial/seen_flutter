import 'package:dartz/dartz.dart';
import 'package:enmaa/features/add_new_real_estate/data/data_source/add_new_real_estate_remote_data_source.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';
import 'package:enmaa/features/add_new_real_estate/domain/repository/base_add_new_real_estate_repository.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/services/handle_api_request_service.dart';

class AddNewRealEstateRepository extends BaseAddNewRealEstateRepository {
  final BaseAddNewRealEstateDataSource baseAddNewRealEstateDataSource;

  AddNewRealEstateRepository({required this.baseAddNewRealEstateDataSource});

  @override
  Future<Either<Failure, void>> addNewApartment(
      ApartmentRequestModel apartment) async {
    return await HandleRequestService.handleApiCall<void>(() async {
      await baseAddNewRealEstateDataSource.addApartment(apartment);
    });
  }
}
