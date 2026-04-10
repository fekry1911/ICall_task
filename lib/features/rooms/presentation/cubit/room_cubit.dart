import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_rooms.dart';
import 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final GetRooms getRoomsUseCase;

  RoomCubit({required this.getRoomsUseCase}) : super(RoomInitial());

  Future<void> fetchRooms() async {
    emit(RoomLoading());
    try {
      final rooms = await getRoomsUseCase();
      emit(RoomLoaded(rooms));
    } catch (e) {
      if (e is Failure) {
        emit(RoomError(e.message));
      } else {
        emit(RoomError(e.toString()));
      }
    }
  }
}
