import '../../domain/entities/booking.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<Booking> bookings;

  BookingLoaded(this.bookings);
}

class BookingCreating extends BookingState {}

class BookingCreated extends BookingState {}

class BookingError extends BookingState {
  final String message;

  BookingError(this.message);
}

class BookingCreateError extends BookingState {
  final String message;

  BookingCreateError(this.message);
}