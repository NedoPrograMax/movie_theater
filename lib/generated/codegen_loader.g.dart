// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "restart_for_localize": "Restart is needed to localize the app",
  "back": "Back",
  "ok": "Ok",
  "uah": "UAH",
  "email_hint": "Your email for tickets to be sent to",
  "invalid_emial": "Not a valid email",
  "pay": "Pay",
  "invalid_card_fields": "Invalid fields are: ",
  "card_number": "Card number",
  "expire_date": "Expire date",
  "booking_exit": "Are you sure you want to exit this screen? If so, there will be no possibility to buy booked seats in 15 minutes",
  "no": "No",
  "yes": "Yes",
  "username_hint": "Enter your name here",
  "booking_error": "Some error occured. Probably, the seats are alredy taken",
  "zero_booked": "You should choose some seets before booking them",
  "book": "Book",
  "duration": "Duration",
  "directed_by": "Directed by",
  "written_by": "Written by",
  "starring": "Starring",
  "studio": "Studio",
  "original_name": "Original name",
  "continue_button": "Continue",
  "coupon_hint": "Your coupon",
  "user_data": "User data",
  "paying_data": "Paying data",
  "comment_hint": "Share your opinion",
  "share_text": "Here is my brand new ticket to "
};
static const Map<String,dynamic> uk = {
  "restart_for_localize": "Перезавантаження необхідне для локалізації",
  "back": "Назад",
  "ok": "Ок",
  "uah": "грн.",
  "email_hint": "Ваш e-mail для отримання квитків",
  "invalid_emial": "Неіснуючий e-mail",
  "pay": "Заплатити",
  "invalid_card_fields": "Невірні поля: ",
  "card_number": "Номер картки",
  "expire_date": "Термін дії",
  "booking_exit": "Ви впевнені, що хочете покинути цей екран? Якщо так, у вас не буде можливості купити заброньовані місця протягом 15-ти хвилин",
  "no": "Ні",
  "yes": "Так",
  "username_hint": "Уведіть своє ім'я тут",
  "booking_error": "Якась помилка. Скоріше за все, ці місця вже зайняті",
  "zero_booked": "Ви повинні обрати якісь місця щоб забронювати їх",
  "book": "Забронювати",
  "duration": "Тривалість",
  "directed_by": "Режисер",
  "written_by": "Сценарій",
  "starring": "Знімаються",
  "studio": "Студія",
  "original_name": "Оригінальна назва",
  "continue_button": "Продовжити",
  "coupon_hint": "Ваш купон",
  "user_data": "Дані користувача",
  "paying_data": "Платіжні дані",
  "comment_hint": "Поділіться своєю думкою",
  "share_text": "Ось мій новесенький білет на "
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "uk": uk};
}
