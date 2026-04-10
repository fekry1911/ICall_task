import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/booking.dart';

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20.r,
            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary, size: 24.w),
          ),
          title: Text(
            booking.userName, 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 4.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, size: 14.w, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(booking.date, style: TextStyle(fontSize: 13.sp)),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, size: 14.w, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text('${booking.startTime} - ${booking.endTime}', style: TextStyle(fontSize: 13.sp)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
