// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';

part 'product.g.dart';

//enum ProductCategory { Pin, Print, Sticker }
//enum Provider { HoneyPie, GarnetStore, WorldPrint, Impactarte, undefined }

@HiveType(typeId: 1)
enum ProductCategory {
  @HiveField(0) Pin,
  @HiveField(1) Print,
  @HiveField(2) Sticker
}

@HiveType(typeId: 2)
enum Provider {
  @HiveField(0) HoneyPie,
  @HiveField(1) GarnetStore,
  @HiveField(2) WorldPrint,
  @HiveField(3) Impactarte,
  @HiveField(4) undefined
}

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double cost;

  @HiveField(3)
  double price;

  @HiveField(4)
  int stock;

  @HiveField(5)
  ProductCategory category;

  @HiveField(6)
  Provider provider;

  @HiveField(7)
  int? promoQuantity;
  
  @HiveField(8)
  double? promoPrice;

  Product({
    required this.name,
    required this.cost,
    required this.price,
    required this.stock,
    required this.category,
    required this.provider,
    this.promoQuantity,
    this.promoPrice
  }) : id = '${name}_${category.name}_${provider.name}';
}
