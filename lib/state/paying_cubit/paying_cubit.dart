import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/repositories/network_repository.dart';
import 'package:movie_theater/models/exceptions.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/session/seat.dart';
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/state/paying_cubit/paying_state.dart';

typedef SetPayingData = void Function({
  String? cardNumber,
  String? expireDate,
  String? cvc,
});

class PayingCubit extends Cubit<PayingState> {
  PayingCubit()
      : super(
          PayingState(
            cardNumber: "0000000000000000",
            expireDate: "00/00",
            cvv: "000",
            email: "",
            discount: 0,
          ),
        );

  void setData({
    String? cardNumber,
    String? expireDate,
    String? cvv,
    String? email,
  }) =>
      emit(
        state.copyWith(
          cardNumber: cardNumber,
          expireDate: expireDate,
          cvv: cvv,
          email: email,
        ),
      );

  String? validate() {
    String? result = "";
    if (state.cardNumber.length != 16) {
      result = LocaleKeys.card_number.tr();
    }
    if (state.expireDate.length != 5) {
      if (result.isEmpty) {
        result = LocaleKeys.expire_date.tr();
      } else {
        result = '$result, ${LocaleKeys.expire_date.tr()}';
      }
    }
    if (state.cvv.length != 3) {
      if (result.isEmpty) {
        result = "CVV";
      } else {
        result = '$result, CVC';
      }
    }
    if (result.isNotEmpty) {
      return "${LocaleKeys.invalid_card_fields.tr()}$result";
    }
    return null;
  }

  Future<bool> buySeats(List<SeatModel> seats) async {
    try {
      return await sl<NetworkRepository>().buySeats(
        seats: seats,
        email: state.email,
        cardNumber: state.cardNumber,
        expireDate: state.expireDate,
        cvv: state.cvv,
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(errorText: e.message),
      );
      return false;
    }
  }

  void setCoupon(String coupon) {
    switch (coupon) {
      case validCoupon:
        emit(state.copyWith(discount: 0.2));
        return;
    }
    return;
  }

  void reset() {
    emit(
      PayingState(
        cardNumber: "0000000000000000",
        expireDate: "00/00",
        cvv: "000",
        email: "",
        discount: 0,
      ),
    );
  }
}
