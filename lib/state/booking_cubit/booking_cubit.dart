import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';

import 'package:movie_theater/state/booking_cubit/booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  var isSomethingBooked = false;
  BookingCubit() : super(BookingState.empty());

  void addSeat(SeatModel seat) {
    state.bookedSeats.add(seat);
    _updatePrice();
  }

  void removeSeat(SeatModel seat) {
    state.bookedSeats.remove(seat);
    _updatePrice();
  }

  void _updatePrice() {
    final price = state.bookedSeats.fold(
      0,
      (previousValue, element) => previousValue + element.price,
    );

    emit(
      BookingState(
        bookedSeats: state.bookedSeats,
        price: price,
      ),
    );
  }

  Future<bool> bookSeats() async {
    final success = await sl<NetworkRepository>().bookSeats(
      state.bookedSeats.toList(),
    );
    if (success) {
      isSomethingBooked = true;
      return true;
    }
    return false;
  }

  void reset() {
    isSomethingBooked = false;
    emit(BookingState.empty());
  }
}
