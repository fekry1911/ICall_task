import '../../domain/entities/room.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_remote_data_source.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDataSource remoteDataSource;

  RoomRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Room>> getRooms() async {
    return await remoteDataSource.getRooms();
  }
}
