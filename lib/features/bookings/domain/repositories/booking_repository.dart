import '../entities/booking.dart';

abstract class BookingRepository {
  Future<List<Booking>> getBookings(int roomId);
  Future<Booking> createBooking(Booking booking);
}
