import 'package:get_it/get_it.dart';

// Bookings
import '../../features/bookings/data/datasources/booking_remote_data_source.dart';
import '../../features/bookings/data/repositories/booking_repository_impl.dart';
import '../../features/bookings/domain/repositories/booking_repository.dart';
import '../../features/bookings/domain/usecases/create_booking.dart';
import '../../features/bookings/domain/usecases/get_bookings.dart';
import '../../features/bookings/presentation/cubit/booking_cubit.dart';
// Rooms
import '../../features/rooms/data/datasources/room_remote_data_source.dart';
import '../../features/rooms/data/repositories/room_repository_impl.dart';
import '../../features/rooms/domain/repositories/room_repository.dart';
import '../../features/rooms/domain/usecases/get_rooms.dart';
import '../../features/rooms/presentation/cubit/room_cubit.dart';
import '../api/api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<ApiConfig>(() => ApiConfig());

  // Cubit
  sl.registerFactory(() => RoomCubit(getRoomsUseCase: sl()));
  sl.registerFactory(
    () => BookingCubit(getBookingsUseCase: sl(), createBookingUseCase: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetRooms(sl()));
  sl.registerLazySingleton(() => GetBookings(sl()));
  sl.registerLazySingleton(() => CreateBooking(sl()));

  // Repository
  sl.registerLazySingleton<RoomRepository>(
    () => RoomRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<RoomRemoteDataSource>(
    () => RoomRemoteDataSourceImpl(apiClient: sl()),
  );
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(apiClient: sl()),
  );
}
