// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sale.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaleAdapter extends TypeAdapter<Sale> {
  @override
  final int typeId = 3;

  @override
  Sale read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sale(
      paymentMethod: fields[2] as PaymentMethod,
      total: fields[3] as double,
      datetime: fields[1] as DateTime,
      id: fields[0] as String,
    )..productsSold = (fields[4] as List).cast<String>();
  }

  @override
  void write(BinaryWriter writer, Sale obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.datetime)
      ..writeByte(2)
      ..write(obj.paymentMethod)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.productsSold);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PaymentMethodAdapter extends TypeAdapter<PaymentMethod> {
  @override
  final int typeId = 4;

  @override
  PaymentMethod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentMethod.Efectivo;
      case 1:
        return PaymentMethod.Tarjeta;
      case 2:
        return PaymentMethod.Transferencia;
      default:
        return PaymentMethod.Efectivo;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentMethod obj) {
    switch (obj) {
      case PaymentMethod.Efectivo:
        writer.writeByte(0);
        break;
      case PaymentMethod.Tarjeta:
        writer.writeByte(1);
        break;
      case PaymentMethod.Transferencia:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
