import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../home_module/home_imports.dart';

part 'preview_property_state.dart';

class PreviewPropertyCubit extends Cubit<PreviewPropertyState> {
  PreviewPropertyCubit() : super(PreviewPropertyState());

  void changePreviewDateVisibility() {
    emit(state.copyWith(showPreviewDate: !state.showPreviewDate));
  }
  void selectDate(DateTime? date) {
    emit(state.copyWith(selectedDate: date));
  }

  void changePreviewTimeVisibility() {
    emit(state.copyWith(showPreviewTime: !state.showPreviewTime));
  }
  void selectTime(TimeOfDay? time) {
    emit(state.copyWith(selectedTime: time));
  }

}
