import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'booking_card.dart';

class ExistingBookingsTab extends StatelessWidget {
  const ExistingBookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is BookingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BookingLoaded || context.read<BookingCubit>().currentBookings.isNotEmpty) {
          final bookings = context.read<BookingCubit>().currentBookings;
          if (bookings.isEmpty) {
            return Center(
              child: Text('No existing bookings.', style: TextStyle(fontSize: 16.sp))
                  .animate()
                  .fadeIn(duration: 300.ms)
                  .scale(begin: const Offset(0.9, 0.9)),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              return BookingCard(booking: bookings[index])
                  .animate()
                  .fadeIn(duration: 300.ms, delay: (50 * index).ms)
                  .slideX(begin: 0.1, end: 0, curve: Curves.easeOutCubic);
            },
          );
        } else if (state is BookingError) {
          return Center(
            child: Text(state.message, style: TextStyle(fontSize: 16.sp, color: Colors.red))
                .animate()
                .shake(duration: 400.ms),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
