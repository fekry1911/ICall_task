import '../../../../core/api/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/api/api_error_handler.dart';
import '../models/room_model.dart';

abstract class RoomRemoteDataSource {
  Future<List<RoomModel>> getRooms();
}

class RoomRemoteDataSourceImpl implements RoomRemoteDataSource {
  final ApiConfig apiClient;

  RoomRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<RoomModel>> getRooms() async {
    try {
      final response = await apiClient.dio.get(AppConstants.getRooms);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => RoomModel.fromJson(json)).toList();
      } else {
        throw const ServerFailure('Failed to load rooms');
      }
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
