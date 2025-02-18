
import '../utils/enums.dart';

extension OperationTypePropertyExtension on PropertyOperationType {
  bool get isForSale => this == PropertyOperationType.forSale;
  bool get isForRent => this == PropertyOperationType.forRent;
}