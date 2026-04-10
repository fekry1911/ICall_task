import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

class GetBookings {
  final BookingRepository repository;

  GetBookings(this.repository);

  Future<List<Booking>> call(int roomId) async {
    return await repository.getBookings(roomId);
  }
}
