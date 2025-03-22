import 'package:hive/hive.dart';
import 'product.dart';

part 'sale_product.g.dart';

@HiveType(typeId: 5)
class SaleProduct extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final Product product;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final double unitPrice;

  @HiveField(4)
  final String sale;

  SaleProduct({
    required this.product,
    required this.quantity,
    required this.sale
  }) : unitPrice = product.price, id = '${sale}_${product.name}';
}
