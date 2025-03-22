// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      name: fields[1] as String,
      cost: fields[2] as double,
      price: fields[3] as double,
      stock: fields[4] as int,
      category: fields[5] as ProductCategory,
      provider: fields[6] as Provider,
      promoQuantity: fields[7] as int?,
      promoPrice: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.stock)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.provider)
      ..writeByte(7)
      ..write(obj.promoQuantity)
      ..writeByte(8)
      ..write(obj.promoPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductCategoryAdapter extends TypeAdapter<ProductCategory> {
  @override
  final int typeId = 1;

  @override
  ProductCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ProductCategory.Pin;
      case 1:
        return ProductCategory.Print;
      case 2:
        return ProductCategory.Sticker;
      default:
        return ProductCategory.Pin;
    }
  }

  @override
  void write(BinaryWriter writer, ProductCategory obj) {
    switch (obj) {
      case ProductCategory.Pin:
        writer.writeByte(0);
        break;
      case ProductCategory.Print:
        writer.writeByte(1);
        break;
      case ProductCategory.Sticker:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProviderAdapter extends TypeAdapter<Provider> {
  @override
  final int typeId = 2;

  @override
  Provider read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Provider.HoneyPie;
      case 1:
        return Provider.GarnetStore;
      case 2:
        return Provider.WorldPrint;
      case 3:
        return Provider.Impactarte;
      case 4:
        return Provider.undefined;
      default:
        return Provider.HoneyPie;
    }
  }

  @override
  void write(BinaryWriter writer, Provider obj) {
    switch (obj) {
      case Provider.HoneyPie:
        writer.writeByte(0);
        break;
      case Provider.GarnetStore:
        writer.writeByte(1);
        break;
      case Provider.WorldPrint:
        writer.writeByte(2);
        break;
      case Provider.Impactarte:
        writer.writeByte(3);
        break;
      case Provider.undefined:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProviderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
