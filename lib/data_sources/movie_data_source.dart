import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_theater/core/constants.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/core/utils.dart';
import 'package:movie_theater/models/comment/comment.dart';
import 'package:movie_theater/models/error_model.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/response_model.dart';
import 'package:movie_theater/models/session/session.dart';
import 'package:intl/intl.dart';
import 'package:movie_theater/models/session/session_model.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/services/authentication.dart';
import 'package:movie_theater/services/locale.dart';

import '../exceptions.dart';

class MovieDataSource {
  Map<String, dynamic> _getHeaders() {
    return {
      "Authorization": "Bearer ${Authentication.instance().accesToken ?? ""}",
      "Accept-Language": Locale.instance().locale,
    };
  }

  Future<List<Session>> fetchSessions(int movieId, DateTime date) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    final format = DateFormat().addPattern("y-MM-dd");
    final dateTime = format.format(date);
    try {
      final sessionsResponse = await dio.get(
        "/api/movies/sessions?movieId=$movieId&date=$dateTime",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final sessionsData = ResponseModel.fromJson(sessionsResponse.data);
      if (sessionsData.success) {
        final sessions = <Session>[];
        final sessionsModels = sessionsData.data as List<dynamic>;
        sessionsModels.forEach((element) {
          final session = Session.fromJson(element);

          sessions.add(Session.fromJson(element));
        });
        return sessions;
      } else {
        final errorText = sessionsData.data as String;
        return Future.error(ApiException(errorText));
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Movie>> fetchMovies(DateTime date, [String? search]) async {
    final dio = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
    final format = DateFormat().addPattern("y-MM-dd");
    final dateTime = format.format(date);
    try {
      final moviesResponse = await dio.get(
        "/api/movies?date=$dateTime${search != null && search.trim().isNotEmpty ? "&query=$search" : ''}",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final moviesData = ResponseModel.fromJson(moviesResponse.data);
      if (moviesData.success) {
        final movies = <Movie>[];
        final moviesModels = moviesData.data as List<dynamic>;
        moviesModels.forEach((element) {
          movies.add(Movie.fromJson(element));
        });
        return movies;
      } else {
        final errorText = moviesData.data as String;
        return Future.error(ApiException(errorText));
      }
    } on DioError catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> bookSeats(List<int> seats, int sessionId) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    final bookResponse = await dio.post(
      "/api/movies/book",
      data: {
        "seats": seats,
        "sessionId": sessionId,
      },
      options: Options(
        headers: _getHeaders(),
      ),
    );
    final bookData = ResponseModel.fromJson(bookResponse.data);
    return bookData.data as bool;
  }

  Future<bool> buySeats({
    required List<int> seats,
    required int sessionId,
    required String email,
    required String cardNumber,
    required String expireDate,
    required String cvv,
  }) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    try {
      final bookResponse = await dio.post(
        "/api/movies/buy",
        data: {
          "seats": seats,
          "sessionId": sessionId,
          "email": email,
          "cardNumber": cardNumber,
          "expirationDate": expireDate,
          "cvv": cvv,
        },
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final bookData = ResponseModel.fromJson(bookResponse.data);
      return bookData.data as bool;
    } on DioError catch (e) {
      final response = ResponseModel.fromJson(e.response?.data);
      final errors = response.data as List<dynamic>;
      final errorModels = errors.map((error) => ErrorModel.fromJson(error));
      final message = errorModels.fold(
          "",
          (previousValue, element) =>
              " $previousValue Problem with ${element.property}: ${element.error}\n");
      return Future.error(ApiException(message));
    }
  }

  Future<Session> fetchSession(int sessionId) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final sessionResponse = await dio.get(
        "/api/movies/sessions/$sessionId",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final sessionData = ResponseModel.fromJson(sessionResponse.data);
      if (sessionData.success) {
        final session = Session.fromJson(sessionData.data as dynamic);

        return session;
      } else {
        final errorText = sessionData.data as String;
        return Future.error(ApiException(errorText));
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<TicketModel>> fetchTickets() async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final response = await dio.get(
        "/api/user/tickets",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final data = ResponseModel.fromJson(response.data);
      if (data.success) {
        final tickets = (data.data as List<dynamic>)
            .map((json) => TicketModel.fromJson(json as dynamic));
        final movieImagesSet = tickets.map((e) => e.image).toSet();
        final colorsMap = {};

        final colorsList = await Future.wait(
          movieImagesSet.map(
            (image) => getColors(
              image,
            ),
          ),
        );
        for (int i = 0; i < movieImagesSet.length; i++) {
          colorsMap.putIfAbsent(
              movieImagesSet.elementAt(i), () => colorsList[i]);
        }
        final list = <TicketModel>[];
        tickets.forEach((ticket) {
          list.add(ticket.withColors(colorsMap[ticket.image]));
        });

        return list;
      } else {
        final errorText = data.data as String;
        return Future.error(ApiException(errorText));
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Comment>> fetchComments(int movieId) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final response = await dio.get(
        "/api/movies/comments?movieId=$movieId",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final data = ResponseModel.fromJson(response.data);
      if (data.success) {
        final comments = (data.data as List<dynamic>).map((json) {
          final comment = Comment.fromJson(json as dynamic);
          return comment;
        }).toList();
        return comments;
      } else {
        final errorText = data.data as String;
        return Future.error(ApiException(errorText));
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> postComment(int movieId, String content, double rating) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final response = await dio.post(
        "/api/movies/comments",
        data: {
          "content": content,
          "rating": rating,
          "movieId": movieId,
        },
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final data = ResponseModel.fromJson(response.data);
      return data.success;
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> deleteComment(int commentId) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final response = await dio.delete(
        "/api/movies/comments/$commentId",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final data = ResponseModel.fromJson(response.data);
      return data.success;
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<bool> updateUsername(String username) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final response = await dio.post(
        "/api/user",
        data: {
          "name": username,
        },
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final data = ResponseModel.fromJson(response.data);
      return data.success;
    } catch (e) {
      return Future.value(false);
    }
  }

  Future<String?> fetchUsername() async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final response = await dio.get(
        "/api/user",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final data = ResponseModel.fromJson(response.data);
      return (data.data as dynamic)["name"];
    } catch (e) {
      return Future.value(null);
    }
  }

  Future<Movie> fetchMovie(int movieId) async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));

    try {
      final movieResponse = await dio.get(
        "/api/movies/$movieId",
        options: Options(
          headers: _getHeaders(),
        ),
      );
      final movieData = ResponseModel.fromJson(movieResponse.data);
      if (movieData.success) {
        final movie = Movie.fromJson(movieData.data as dynamic);

        return movie;
      } else {
        final errorText = movieData.data as String;
        return Future.error(ApiException(errorText));
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
