// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      id: json['id'] as int,
      movieId: json['movieId'] as int,
      name: json['name'] as String,
      date: json['date'] as int,
      image: json['image'] as String,
      smallImage: json['smallImage'] as String,
      roomName: json['roomName'] as String,
      seatIndex: json['seatIndex'] as int,
      rowIndex: json['rowIndex'] as int,
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'name': instance.name,
      'date': instance.date,
      'image': instance.image,
      'smallImage': instance.smallImage,
      'roomName': instance.roomName,
      'seatIndex': instance.seatIndex,
      'rowIndex': instance.rowIndex,
    };
