import 'dart:async';
import 'package:dio/dio.dart';
import 'package:enmaa/core/constants/api_constants.dart';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/core/services/select_location_service/data/models/city_model.dart';
import 'package:enmaa/core/services/select_location_service/data/models/country_model.dart';
import 'package:enmaa/core/services/select_location_service/data/models/state_model.dart';
import 'package:enmaa/core/services/select_location_service/domain/entities/country_entity.dart';

abstract class BaseSelectLocationRemoteDataSource {
  Future<List<CountryModel>> getCountries();
  Future<List<StateModel>> getStates(String countryId);
  Future<List<CityModel>> getCities(String stateId);
}

class SelectLocationRemoteDataSource extends BaseSelectLocationRemoteDataSource {
  final DioService dioService;

  SelectLocationRemoteDataSource({required this.dioService});

  @override
  Future<List<CountryModel>> getCountries() async {
    final response = await dioService.get(url: ApiConstants.countries);
    final List<dynamic> results = response.data['results'] ?? [];

    List<CountryModel> countries =  results.map((json) {
      return CountryModel.fromJson(json);
    }).toList();

   return countries;
  }

  @override
  Future<List<StateModel>> getStates(String countryId) async {
    final formData = FormData.fromMap({
      'country': countryId,
    });

    final response = await dioService.get(
      url: ApiConstants.states,
      body: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    final List<dynamic> results = response.data['results'] ?? [];
    List<StateModel> states = results.map((json) {
      return StateModel.fromJson(json);
    }).toList();
    return states;
  }

  @override
  Future<List<CityModel>> getCities(String stateId) async {
    final formData = FormData.fromMap({
      'state': stateId,
    });
    final response = await dioService.get(
      url: ApiConstants.cities,
      body: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    final List<dynamic> results = response.data['results'] ?? [];
    List<CityModel> cities = results.map((json) {
      return CityModel.fromJson(json);
    }).toList();
    return cities;
  }
}
