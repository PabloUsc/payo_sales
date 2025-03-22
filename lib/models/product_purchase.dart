import 'package:hive/hive.dart';
import 'product.dart';

part 'product_purchase.g.dart';

@HiveType(typeId: 7)
class ProductPurchase extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime datetime;

  @HiveField(2)
  final Product product;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final double unitPrice;

  @HiveField(5)
  final double totalCost;

  ProductPurchase({
    required this.product,
    required this.quantity,
    required this.totalCost,
  }) : id = '${product.name}_${DateTime.now().toString()}_${quantity}_$totalCost', unitPrice = totalCost/quantity, datetime = DateTime.now();
}
