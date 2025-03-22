// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductPurchaseAdapter extends TypeAdapter<ProductPurchase> {
  @override
  final int typeId = 7;

  @override
  ProductPurchase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductPurchase(
      product: fields[2] as Product,
      quantity: fields[3] as int,
      totalCost: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProductPurchase obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.datetime)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.unitPrice)
      ..writeByte(5)
      ..write(obj.totalCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductPurchaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
