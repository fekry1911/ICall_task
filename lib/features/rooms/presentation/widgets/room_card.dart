import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../bookings/presentation/pages/booking_page.dart';
import '../../domain/entities/room.dart';

class RoomCard extends StatefulWidget {
  final Room room;
  final int index;

  const RoomCard({super.key, required this.room, this.index = 0});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: 20.h),
        transform: Matrix4.diagonal3Values(_isHovered ? 1.02 : 1.0, _isHovered ? 1.02 : 1.0, 1.0),
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFFDFDFD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.room.name,
                            style: GoogleFonts.outfit(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E1E2D),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Capacity: ${widget.room.capacity}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ).animate().scale(delay: (400 + widget.index * 100).ms, duration: 400.ms, curve: Curves.easeOutBack),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => BookingPage(room: widget.room),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Book Now'),
                            SizedBox(width: 8.w),
                            Icon(Icons.arrow_forward_rounded, size: 18.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).animate()
     .fadeIn(duration: 400.ms, delay: (widget.index * 100).ms)
     .slideY(begin: 0.2, end: 0, duration: 400.ms, curve: Curves.easeOutCubic);
  }
}
