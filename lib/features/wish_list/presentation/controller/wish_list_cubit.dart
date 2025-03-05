import 'package:bloc/bloc.dart';
import 'package:enmaa/core/utils/enums.dart';
import 'package:enmaa/features/wish_list/domain/use_cases/get_properties_wish_list_use_case.dart';
import 'package:enmaa/features/wish_list/domain/use_cases/remove_property_from_wish_list_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../data/models/property_wish_list_model.dart';
import '../../domain/entities/property_wish_list_entity.dart';

part 'wish_list_state.dart';

class WishListCubit extends HydratedCubit<WishListState> {
  WishListCubit(this._getPropertiesWishListUseCase , this._removePropertyFromWishListUseCase) : super(WishListState());

  final GetPropertiesWishListUseCase _getPropertiesWishListUseCase ;
  final RemovePropertyFromWishListUseCase _removePropertyFromWishListUseCase ;

  void getPropertyWishList() async{
    emit(state.copyWith(getPropertyWishListState: RequestState.loading));
    final result = await _getPropertiesWishListUseCase();
    print("get data ${result}");
     result.fold(
      (failure) => emit(state.copyWith(getPropertyWishListState: RequestState.error, getPropertyWishListFailureMessage: failure.message)),
      (propertyWishList) => emit(state.copyWith(getPropertyWishListState: RequestState.loaded, propertyWishList: propertyWishList)),
    );
  }

  void removePropertyFromWishList(String propertyId) async{

    final updatedList = List<PropertyWishListEntity>.from(state.propertyWishList)
      ..removeWhere((item) => item.id.toString() == propertyId);

    emit(state.copyWith(
      propertyWishList: updatedList,
      getPropertyWishListState: RequestState.loading,
    ));

    emit(state.copyWith(getPropertyWishListState: RequestState.loading));
    final result = await _removePropertyFromWishListUseCase(propertyId);

    print("remove item from is ${result}") ;
    result.fold(
          (failure) {
         emit(state.copyWith(
          propertyWishList: state.propertyWishList,
          getPropertyWishListState: RequestState.loaded,
         ));
      },
          (_) => emit(state.copyWith(getPropertyWishListState: RequestState.loaded)),
    );
  }

  @override
  WishListState? fromJson(Map<String, dynamic> json) {
   /* try {
      return WishListState(
        propertyWishList: (json['propertyWishList'] as List<dynamic>)
            .map((item) => PropertyWishListModel.fromJson(item).toEntity())
            .toList(),
        getPropertyWishListState: RequestState.values[json['getPropertyWishListState']],
        getPropertyWishListFailureMessage: json['getPropertyWishListFailureMessage'],
      );
    } catch (e) {
      return null;
    }*/
  }

  @override
  Map<String, dynamic>? toJson(WishListState state) {
    /*try {
      return {
        'propertyWishList': state.propertyWishList
            .map((entity) => PropertyWishListModel.fromEntity(entity).toJson())
            .toList(),
        'getPropertyWishListState': 2,
        'getPropertyWishListFailureMessage': state.getPropertyWishListFailureMessage,
      };
    } catch (e) {
      return null;
    }*/
  }

}
