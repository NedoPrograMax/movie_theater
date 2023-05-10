import 'dart:math';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/core/routes/movies_routes_generator.dart';
import 'package:movie_theater/generated/locale_keys.g.dart';
import 'package:movie_theater/models/response_model.dart';
import 'package:movie_theater/state/booking_cubit/booking_cubit.dart';
import 'package:movie_theater/state/paying_cubit/paying_cubit.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:share_plus/share_plus.dart';

import '../services/authentication.dart';
import 'dart:ui' as ui;
import '../state/comments_cubit/comments_cubit.dart';
import 'extensions.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<ImageProvider?> getImageProvider(String path) async {
  final dio = Dio(
    BaseOptions(baseUrl: baseUrl, responseType: ResponseType.bytes),
  );
  try {
    final bytesResponse = await dio.get(
      "/$path",
      options: Options(
        headers: {
          "Authorization":
              "Bearer ${Authentication.instance().accesToken ?? ""}",
        },
      ),
    );
    return NetworkImage(path);
  } catch (e) {
    return null;
  }
}

Future<List<Color>> getColors(String url) async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    ResizeImage(
      NetworkImage(
        url,
      ),
      height: 327,
      width: 218,
    ),
  );
  return paletteGenerator.colors.toList();
}

Future<bool> shouldPopBooking(BuildContext context) async {
  final isSomethingBooked = context.read<BookingCubit>().isSomethingBooked;
  bool? doExit = true;
  if (isSomethingBooked) {
    doExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          LocaleKeys.booking_exit.tr(),
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(LocaleKeys.no.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(LocaleKeys.yes.tr()),
          ),
        ],
      ),
    );
  }
  if (doExit == true) {
    context.read<BookingCubit>().reset();
    context.read<PayingCubit>().reset();
    return true;
  }
  return false;
}

Future<double> getImageAssetAspectRatio(String asset) async {
  final bytes = await rootBundle.load(asset);
  var decodedImage = await decodeImageFromList(bytes.buffer.asUint8List());
  return decodedImage.width / decodedImage.height;
}

bool newTicketsScreenPop(BuildContext context) {
  Navigator.of(context).popUntil((route) => route.isFirst);
  context.read<BookingCubit>().reset();
  return true;
}

Future<bool> dealWithPop(
  int index,
  GlobalKey<NavigatorState> moviesNavigator,
  GlobalKey<NavigatorState> profileNavigator,
  BuildContext context,
) async {
  if (index == 0) {
    if (moviesNavigator.currentState?.canPop() != true) {
      return Future.value(true);
    }
    if (moviesNavigator.currentState?.currentRoute ==
        MoviesRoutesGenerator.booking) {
      if (await shouldPopBooking(context)) {
        moviesNavigator.currentState?.pop();
      }
    } else if (moviesNavigator.currentState?.currentRoute ==
        MoviesRoutesGenerator.movie) {
      context.read<CommentsCubit>().reset();
      moviesNavigator.currentState?.pop();
    } else if (moviesNavigator.currentState?.currentRoute ==
        MoviesRoutesGenerator.newTickets) {
      moviesNavigator.currentState?.popUntil((route) => route.isFirst);
      context.read<BookingCubit>().reset();
    } else {
      moviesNavigator.currentState?.pop();
    }
    return Future.value(false);
  } else if (index == 2) {
    if (profileNavigator.currentState?.canPop() != true) {
      return Future.value(true);
    } else {
      profileNavigator.currentState?.pop();
    }
    return Future.value(false);
  }
  return Future.value(false);
}

int findWidth(int mult) {
  for (int i = 2; i < mult; i++) {
    final height = mult / i;
    if (height == height.toInt()) {
      return i;
    }
  }
  return 1;
}

bool _isComputingValueInt(int lenght) => (sqrt((lenght ~/ 4) / 6.0)).isInt();
