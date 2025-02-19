import 'dart:async';
import 'package:enmaa/core/services/dio_service.dart';
import 'package:enmaa/core/services/select_location_service/data/models/city_model.dart';
import 'package:enmaa/core/services/select_location_service/data/models/country_model.dart';
import 'package:enmaa/core/services/select_location_service/data/models/state_model.dart';

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
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    return [
      CountryModel(id: '1', name: "Egypt"),
      CountryModel(id: '2', name: "United States"),
      CountryModel(id: '3', name: "United Kingdom"),
    ];
  }

  @override
  Future<List<StateModel>> getStates(String countryId) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    if (countryId == '1') {
      return [
        StateModel(id: '11', name: "Cairo"),
        StateModel(id: '12', name: "Giza"),
      ];
    } else if (countryId == '2') {
      return [
        StateModel(id: '21', name: "California"),
        StateModel(id: '22', name: "Texas"),
      ];
    } else {
      return [
        StateModel(id: '31', name: "London"),
        StateModel(id: '32', name: "Manchester"),
      ];
    }
  }

  @override
  Future<List<CityModel>> getCities(String stateId) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    if (stateId == '11') {
      return [
        CityModel(id: '111', name: "Nasr City"),
        CityModel(id: '112', name: "Heliopolis"),
      ];
    } else if (stateId == '21') {
      return [
        CityModel(id: '211', name: "Los Angeles"),
        CityModel(id: '212', name: "San Francisco"),
      ];
    } else {
      return [
        CityModel(id: '311', name: "Camden"),
        CityModel(id: '312', name: "Westminster"),
      ];
    }
  }
}
