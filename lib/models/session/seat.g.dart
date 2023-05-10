// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
      id: json['id'] as int,
      index: json['index'] as int,
      type: json['type'] as int,
      price: json['price'] as int,
      isAvailable: json['isAvailable'] as bool,
    );

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'type': instance.type,
      'price': instance.price,
      'isAvailable': instance.isAvailable,
    };
