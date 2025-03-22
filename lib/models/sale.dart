// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';

part 'sale.g.dart';

@HiveType(typeId: 4)
enum PaymentMethod {
  @HiveField(0) Efectivo,
  @HiveField(1) Tarjeta,
  @HiveField(2) Transferencia
}

@HiveType(typeId: 3)
class Sale extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime datetime; // Date and time of the sale

  @HiveField(2)
  final PaymentMethod paymentMethod; // Payment method for the sale

  @HiveField(3)
  final double total; // Total of the sale

  @HiveField(4)
  List<String> productsSold; // List of sale products sold

  Sale({
    required this.paymentMethod,
    required this.total,
  }) : datetime = DateTime.now(), id = 'Sale_${paymentMethod}_${DateTime.now().toString()}', productsSold = List<String>.empty(growable: true);
}
