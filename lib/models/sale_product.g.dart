// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleProductAdapter extends TypeAdapter<SaleProduct> {
  @override
  final int typeId = 5;

  @override
  SaleProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaleProduct(
      product: fields[1] as Product,
      quantity: fields[2] as int,
      sale: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SaleProduct obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.unitPrice)
      ..writeByte(4)
      ..write(obj.sale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
