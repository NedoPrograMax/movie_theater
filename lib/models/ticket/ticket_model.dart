import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_theater/core/utils.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  final int id;
  final int movieId;
  final String name;
  final int date;
  final String image;
  final String smallImage;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<Color>? colors;
  final String roomName;
  final int seatIndex;
  final int rowIndex;

  TicketModel({
    required this.id,
    required this.movieId,
    required this.name,
    required this.date,
    required this.image,
    required this.smallImage,
    this.colors,
    required this.roomName,
    required this.seatIndex,
    required this.rowIndex,
  });

  TicketModel.empty()
      : id = 1,
        movieId = 0,
        date = 0,
        smallImage = "",
        roomName = "",
        colors = [Colors.blue],
        rowIndex = 0,
        seatIndex = 0,
        name = "Naked Gun",
        image =
            "https://th.bing.com/th/id/R.46471354dcf5afaa6d6c810c947d93f3?rik=Iy6yzYkrykP8xg&pid=ImgRaw&r=0";

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  void setColors(List<Color> colors) {
    colors = colors;
  }

  TicketModel withColors(List<Color> colors) => TicketModel(
        id: id,
        movieId: movieId,
        name: name,
        date: date,
        image: image,
        smallImage: smallImage,
        colors: colors,
        roomName: roomName,
        seatIndex: seatIndex,
        rowIndex: rowIndex,
      );

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
