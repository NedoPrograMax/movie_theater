import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_theater/models/ticket/ticket_model.dart';
import 'package:movie_theater/state/old_tickets_cubit/old_tickets_state.dart';

class OldTicketsCubit extends Cubit<OldTicketsState> {
  List<List<TicketModel>> _tickets = [];
  OldTicketsCubit() : super(OldTicketsState(0));

  void setId(int id) {
    emit(OldTicketsState(id));
  }

  set tickets(List<List<TicketModel>> value) => _tickets = value;

  int getIndexById([int? id]) {
    id ??= state.currenId;
    for (int i = 0; i < _tickets.length; i++) {
      if (_tickets[i].first.id == id) {
        return i;
      }
    }
    return -1;
  }
}
