import 'package:equatable/equatable.dart';

class TransactionHistoryEntity  extends Equatable{
  final String id;
  final String title;
   final String amount;
  final String date;

  const TransactionHistoryEntity({
    required this.id,
    required this.title,
     required this.amount,
    required this.date,
   });

  @override
   List<Object?> get props => [id, title,   amount, date];
}