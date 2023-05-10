import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';

class BookingState {
  final Set<SeatModel> bookedSeats;
  final int price;
  const BookingState({
    required this.bookedSeats,
    required this.price,
  });

  BookingState.empty()
      : bookedSeats = {},
        price = 0;
}
