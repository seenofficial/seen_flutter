import 'package:dartz/dartz.dart';
import 'package:enmaa/features/add_new_real_estate/data/models/apartment_request_model.dart';

import '../../../../core/errors/failure.dart';



abstract class BaseAddNewRealEstateRepository {


  Future<Either<Failure, void>> addNewApartment(ApartmentRequestModel apartment);


}