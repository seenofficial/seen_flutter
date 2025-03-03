part of 'book_property_cubit.dart';

class BookPropertyState extends Equatable {
  const BookPropertyState({
    this.selectedImages = const [],
    this.selectImagesState = RequestState.initial,
    this.validateImages = true ,
   });

  final List<File> selectedImages;
  final RequestState selectImagesState;
  final bool validateImages ;


  BookPropertyState copyWith({

    List<File>? selectedImages,
    RequestState? selectImagesState,
    bool? validateImages ,
  }) {
    return BookPropertyState(
      selectedImages: selectedImages ?? this.selectedImages,
      selectImagesState: selectImagesState ?? this.selectImagesState,
      validateImages: validateImages ?? this.validateImages,

    );
  }

  @override
  List<Object?> get props => [selectedImages, selectImagesState];
}


