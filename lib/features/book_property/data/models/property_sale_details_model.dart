import 'package:enmaa/features/book_property/domain/entities/property_sale_details_entity.dart';

class PropertySaleDetailsModel extends PropertySaleDetailsEntity {
  const PropertySaleDetailsModel({required super.propertyPrice, required super.viewingRequestPrice, required super.bookingDeposit, required super.remainingAmount, required super.bookingDepositPercentage});

  factory PropertySaleDetailsModel.fromJson(Map<String, dynamic> json) {
    return PropertySaleDetailsModel(
      propertyPrice: json['price'].toString(),
      viewingRequestPrice: json['viewing_request_amount'].toString(),
      bookingDeposit: json['booking_deposit'].toString(),
      remainingAmount: json['balance'].toString(),
      bookingDepositPercentage: json['booking_deposit_percent'].toString(),
    );
  }
}