import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_remote_data_source.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;

  BookingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Booking>> getBookings(int roomId) async {
    return await remoteDataSource.getBookings(roomId);
  }

  @override
  Future<Booking> createBooking(Booking booking) async {
    final bookingModel = BookingModel(
      roomId: booking.roomId,
      date: booking.date,
      startTime: booking.startTime,
      endTime: booking.endTime,
      userName: booking.userName,
    );
    return await remoteDataSource.createBooking(bookingModel);
  }
}
