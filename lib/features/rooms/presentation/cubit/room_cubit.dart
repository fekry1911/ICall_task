import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(RoomError(e.toString()));
    }
  }
}
