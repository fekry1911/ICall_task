import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/booking.dart';
import '../../domain/usecases/get_bookings.dart';
import '../../domain/usecases/create_booking.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final GetBookings getBookingsUseCase;
  final CreateBooking createBookingUseCase;

  List<Booking> currentBookings = [];

  BookingCubit({
    required this.getBookingsUseCase,
    required this.createBookingUseCase,
  }) : super(BookingInitial());

  Future<void> fetchBookings(int roomId) async {
    emit(BookingLoading());
    try {
      currentBookings = await getBookingsUseCase(roomId);
      emit(BookingLoaded(currentBookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }

  Future<void> createBooking(Booking booking) async {
    final start = _parseDateTime(booking.date, booking.startTime);
    final end = _parseDateTime(booking.date, booking.endTime);
    if (!start.isBefore(end)) {
      emit(BookingCreateError('End time must be after start time'));
      return;
    }
    if (_hasTimeOverlap(start, end)) {
      emit(BookingCreateError('Time slot is already booked'));
      return;
    }

    emit(BookingCreating());
    try {
      final newBooking = await createBookingUseCase(booking);
      currentBookings.add(newBooking);

      emit(BookingCreated());
      emit(BookingLoaded(List.from(currentBookings)));
    } catch (e) {
      emit(BookingCreateError(e.toString()));
    }
  }

  bool _hasTimeOverlap(DateTime newStart, DateTime newEnd) {
    for (final existing in currentBookings) {
      final existingStart = _parseDateTime(existing.date, existing.startTime);
      final existingEnd = _parseDateTime(existing.date, existing.endTime);

      if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
        return true;
      }
    }
    return false;
  }

  DateTime _parseDateTime(String date, String time) {
    try {
      final d = date.length > 10 ? date.substring(0, 10) : date;
      final t = time.length > 5 ? time.substring(0, 5) : time;
      return DateTime.parse('${d}T$t:00');
    } catch (e) {
      return DateTime.now(); // Fallback to avoid complete crash
    }
  }
}