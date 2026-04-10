import '../../../../core/api/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/api/api_error_handler.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getBookings(int roomId);
  Future<BookingModel> createBooking(BookingModel booking);
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiConfig apiClient;

  BookingRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<BookingModel>> getBookings(int roomId) async {
    try {
      final response = await apiClient.dio.get(
        AppConstants.getBookings,
        queryParameters: {
          'filter[room_id][_eq]': roomId,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => BookingModel.fromJson(json)).toList();
      } else {
        throw const ServerFailure('Failed to load bookings');
      }
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    try {
      final response = await apiClient.dio.post(
        AppConstants.getBookings,
        data: booking.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'];
        return BookingModel.fromJson(data);
      } else {
        throw const ServerFailure('Failed to create booking');
      }
    } catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
