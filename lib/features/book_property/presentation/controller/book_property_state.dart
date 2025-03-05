part of 'book_property_cubit.dart';

class BookPropertyState extends Equatable {
  const BookPropertyState({
    this.selectedImages = const [],
    this.selectImagesState = RequestState.initial,
    this.validateImages = true,
    this.getPropertySaleDetailsState = RequestState.initial,
    this.propertySaleDetailsEntity,
    this.getPropertySaleDetailsError = '',
  });

  final List<File> selectedImages;
  final RequestState selectImagesState;
  final bool validateImages;

  final RequestState getPropertySaleDetailsState;
  final PropertySaleDetailsEntity? propertySaleDetailsEntity;
  final String getPropertySaleDetailsError;

  BookPropertyState copyWith({
    List<File>? selectedImages,
    RequestState? selectImagesState,
    bool? validateImages,
    RequestState? getPropertySaleDetailsState,
    PropertySaleDetailsEntity? propertySaleDetailsEntity,
    String? getPropertySaleDetailsError,
  }) {
    return BookPropertyState(
      selectedImages: selectedImages ?? this.selectedImages,
      selectImagesState: selectImagesState ?? this.selectImagesState,
      validateImages: validateImages ?? this.validateImages,
      getPropertySaleDetailsState:
          getPropertySaleDetailsState ?? this.getPropertySaleDetailsState,
      propertySaleDetailsEntity:
          propertySaleDetailsEntity ?? this.propertySaleDetailsEntity,
      getPropertySaleDetailsError:
          getPropertySaleDetailsError ?? this.getPropertySaleDetailsError,
    );
  }

  @override
  List<Object?> get props => [
        selectedImages,
        selectImagesState,
        validateImages,
        getPropertySaleDetailsState,
        propertySaleDetailsEntity,
        getPropertySaleDetailsError
      ];
}
