import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection_container.dart';
import '../../../rooms/domain/entities/room.dart';
import '../cubit/booking_cubit.dart';
import '../widgets/existing_bookings_tab.dart';
import '../widgets/new_booking_tab.dart';

class BookingPage extends StatelessWidget {
  final Room room;

  const BookingPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BookingCubit>()..fetchBookings(room.id),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(room.name),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              indicatorWeight: 3.h,
              labelStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(fontSize: 15.sp),
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Colors.grey.shade600,
              tabs: const [
                Tab(text: 'Current Bookings'),
                Tab(text: 'Reserve Time'),
              ],
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF8F9FE), Color(0xFFE2E7FE)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: const SafeArea(
              child: TabBarView(
                children: [
                  ExistingBookingsTab(),
                  NewBookingTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
