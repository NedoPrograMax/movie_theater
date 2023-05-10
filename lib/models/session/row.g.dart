// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Row _$RowFromJson(Map<String, dynamic> json) => Row(
      id: json['id'] as int,
      index: json['index'] as int,
      seats: (json['seats'] as List<dynamic>)
          .map((e) => Seat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RowToJson(Row instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'seats': instance.seats.map((e) => e.toJson()).toList(),
    };
