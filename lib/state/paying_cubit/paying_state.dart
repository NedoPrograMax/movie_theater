class PayingState {
  final String cardNumber;
  final String expireDate;
  final String cvv;
  final String email;
  final String? errorText;
  final double discount;

  PayingState({
    required this.cardNumber,
    required this.expireDate,
    required this.cvv,
    required this.email,
    required this.discount,
    this.errorText,
  });

  PayingState copyWith(
          {String? cardNumber,
          String? expireDate,
          String? cvv,
          String? email,
          String? errorText,
          double? discount}) =>
      PayingState(
          cardNumber: cardNumber ?? this.cardNumber,
          expireDate: expireDate ?? this.expireDate,
          cvv: cvv ?? this.cvv,
          email: email ?? this.email,
          errorText: errorText,
          discount: discount ?? this.discount);
}
