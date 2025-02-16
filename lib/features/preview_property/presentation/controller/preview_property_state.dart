part of 'preview_property_cubit.dart';

class PreviewPropertyState extends Equatable {
  const PreviewPropertyState({
    this.showPreviewDate = false,
    this.selectedDate ,
    this.showPreviewTime= false,
    this.selectedTime ,
  });

  final bool showPreviewDate;
  final DateTime? selectedDate;

  final bool showPreviewTime;
  final TimeOfDay? selectedTime;


  PreviewPropertyState copyWith({
    bool? showPreviewDate,
    DateTime? selectedDate,
    bool? showPreviewTime,
    TimeOfDay? selectedTime,
  }) {
    return PreviewPropertyState(
      showPreviewDate: showPreviewDate ?? this.showPreviewDate,
      selectedDate: selectedDate ?? this.selectedDate,
      showPreviewTime: showPreviewTime ?? this.showPreviewTime,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }

  @override
  List<Object?> get props => [showPreviewDate, selectedDate, showPreviewTime, selectedTime];
}
