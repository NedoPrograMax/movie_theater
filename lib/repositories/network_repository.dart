import 'dart:async';

import 'package:intl/intl.dart';
import 'package:movie_theater/core/extensions.dart';
import 'package:movie_theater/data_sources/movie_data_source.dart';
import 'package:movie_theater/models/exceptions.dart';
import 'package:movie_theater/models/comment/comment.dart';
import 'package:movie_theater/models/movie/movie.dart';
import 'package:movie_theater/models/movie/movie_model.dart';
import 'package:movie_theater/models/session/seat_model.dart';
import 'package:movie_theater/models/session/session.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';

import '../models/session/seat.dart';
import '../models/session/session_model.dart';

class NetworkRepository {
  final MovieDataSource movieDataSource;
  List<Movie>? movies;
  List<Session> sessions = [];
  List<SessionModel> sessionModels = [];
  DateTime? currentDate;
  String? lastSearch;
  Session? lastSession;
  final _streamController =
      StreamController<List<List<TicketModel>>>.broadcast();
  NetworkRepository({required this.movieDataSource});

  Future<List<SessionModel>> fetchAllSesionsForDay(DateTime date,
      [String? search]) async {
    sessions = [];
    currentDate = date;
    lastSearch = search;
    movies = await movieDataSource.fetchMovies(date, search);
    sessionModels = <SessionModel>[];
    final sessionsListFuture = movies!.map((movie) async {
      final theseSessions = await movieDataSource.fetchSessions(movie.id, date);
      sessions.addAll(theseSessions);
      return theseSessions.toSessionModels(movie);
    });

    final sesionsList = await Future.wait(sessionsListFuture);
    sesionsList.forEach(
      (sesionsList) {
        sessionModels.addAll(sesionsList);
      },
    );
    sessionModels = sessionModels.removeCopiesAndOlds();
    return sessionModels;
  }

  Movie getMovieFromCache(int movieId) =>
      movies!.firstWhere((element) => element.id == movieId);

  Movie getMovieFromCacheBySessionId(int sessionId) {
    final movieId =
        sessionModels.firstWhere((element) => element.id == sessionId).movieId;

    return getMovieFromCache(movieId);
  }

  Future<Session> fetchSession(int sessionId) async {
    lastSession = await movieDataSource.fetchSession(sessionId);
    return lastSession!;
  }

  Future<List<List<TicketModel>>> _fetchTickets() async =>
      (await movieDataSource.fetchTickets())
          .where(
            (element) => DateTime.fromMillisecondsSinceEpoch(
              element.date * 1000,
              isUtc: true,
            ).isAfter(
              DateTime.now(),
            ),
          )
          .toList()
          .groupSimiliar();

  Future<bool> bookSeats(List<SeatModel> seats) => movieDataSource.bookSeats(
        seats.map((e) => e.id).toList(),
        lastSession?.id ?? 0,
      );

  Future<bool> buySeats({
    required List<SeatModel> seats,
    required String email,
    required String cardNumber,
    required String expireDate,
    required String cvv,
  }) async {
    try {
      final success = await movieDataSource.buySeats(
        seats: seats.map((e) => e.id).toList(),
        sessionId: lastSession?.id ?? 0,
        email: email,
        cardNumber: cardNumber,
        expireDate: expireDate,
        cvv: cvv,
      );
      if (success) {
        _streamController.sink.add(await _fetchTickets());
      }
      return success;
    } on ApiException {
      rethrow;
    }
  }

  Future<List<MovieModel>> fetchMovieModels(DateTime date,
      [String? search]) async {
    if (currentDate?.isSameDay(date) != true || lastSearch != search) {
      await fetchAllSesionsForDay(date, search);
    }

    final futures = movies!
        .map(
          (movie) => movie.toMovieModel(
            sessionModels
                .where((session) => session.movieId == movie.id)
                .toList(),
          ),
        )
        .toList();
    final list = await Future.wait(futures);
    sessionModels.forEach((session) {
      session.colors =
          list.firstWhere((movie) => movie.id == session.movieId).colors;
    });

    return list;
  }

  Future<List<List<SeatModel>>> fetchSeats(int sessionId) async {
    final session = await fetchSession(sessionId);
    return session.room.rows.toSeats();
  }

  Future<List<Comment>> fetchComments(int movieId) =>
      movieDataSource.fetchComments(movieId);

  Future<bool> postComments(int movieId, String content, double rating) =>
      movieDataSource.postComment(movieId, content, rating);

  Future<bool> deleteComment(int commentId) =>
      movieDataSource.deleteComment(commentId);

  Future<List<SessionModel>> fetchAllSesionsForDayIfNeeded(
    DateTime date, [
    String? search,
  ]) async {
    if (currentDate?.isSameDay(date) == true &&
        lastSearch == search &&
        sessionModels.isNotEmpty) {
      return sessionModels;
    }
    return fetchAllSesionsForDay(date, search);
  }

  Future<bool> updateUsername(String username) =>
      movieDataSource.updateUsername(username);

  Future<String?> fetchUsername() => movieDataSource.fetchUsername();

  Future<List<Movie>> fetchConcreteMovies(List<int> movieIds) async {
    final futures = movieIds.map((id) => movieDataSource.fetchMovie(id));
    final movies = await Future.wait(futures);
    return movies;
  }

  Stream<List<List<TicketModel>>> fetchTicketsStream() {
    _fetchTickets().then((value) => _streamController.sink.add(value));
    return _streamController.stream;
  }
}
