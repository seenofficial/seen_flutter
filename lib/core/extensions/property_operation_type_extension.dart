import '../utils/enums.dart';

/// Extension to convert String to OperationType and vice versa
extension OperationTypeExtension on String {
  PropertyOperationType toOperationType() {
    return this == 'for_sale' ? PropertyOperationType.forSale : PropertyOperationType.forRent;
  }
}