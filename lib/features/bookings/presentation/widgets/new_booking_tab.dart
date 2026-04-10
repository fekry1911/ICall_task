import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cherry_toast/cherry_toast.dart';
import '../../domain/entities/booking.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import '../pages/booking_page.dart';
import 'selection_tile.dart';

class NewBookingTab extends StatefulWidget {
  const NewBookingTab({super.key});

  @override
  State<NewBookingTab> createState() => _NewBookingTabState();
}

class _NewBookingTabState extends State<NewBookingTab> {
  final _formKey = GlobalKey<FormState>();
  String? _userName;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  bool get _isFormValid {
    return _userName != null &&
           _userName!.trim().isNotEmpty &&
           _selectedDate != null &&
           _startTime != null &&
           _endTime != null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingCreated) {
          CherryToast.success(title: const Text('Booking Created Successfully!')).show(context);
          _formKey.currentState?.reset();
          setState(() {
            _userName = null;
            _selectedDate = null;
            _startTime = null;
            _endTime = null;
          });
          // Don't fetch bookings immediately to avoid HTTP caching missing the new booking
          // The cubit has already added it locally in createBooking() so the UI updates
        } else if (state is BookingCreateError) {
          CherryToast.error(
            title: const Text('Booking Failed'),
            description: Text(state.message),
            animationDuration: const Duration(milliseconds: 300),
          ).show(context);
        }
      },
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(24.w),
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: Offset(0, 4.h)),
                ],
              ),
              child: TextFormField(
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: TextStyle(fontSize: 16.sp),
                  prefixIcon: Icon(Icons.person_outline, size: 24.w),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (v) => v!.trim().isEmpty ? 'Enter your name' : null,
                onChanged: (v) => setState(() => _userName = v),
                onSaved: (v) => _userName = v,
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1),
            SizedBox(height: 20.h),
            SelectionTile(
              label: _selectedDate == null ? 'Select Date' : '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2,'0')}-${_selectedDate!.day.toString().padLeft(2,'0')}',
              icon: Icons.calendar_today,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  builder: (context, child) => Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(primary: Theme.of(context).colorScheme.primary),
                    ),
                    child: child!,
                  ),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
            ).animate().fadeIn(duration: 400.ms, delay: 100.ms).slideY(begin: 0.1),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: SelectionTile(
                    label: _startTime == null ? 'Start Time' : '${_startTime!.hour.toString().padLeft(2,'0')}:${_startTime!.minute.toString().padLeft(2,'0')}',
                    icon: Icons.access_time,
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (time != null) setState(() => _startTime = time);
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: SelectionTile(
                    label: _endTime == null ? 'End Time' : '${_endTime!.hour.toString().padLeft(2,'0')}:${_endTime!.minute.toString().padLeft(2,'0')}',
                    icon: Icons.access_time,
                    onTap: () async {
                      final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                      if (time != null) setState(() => _endTime = time);
                    },
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 400.ms, delay: 200.ms).slideY(begin: 0.1),
            SizedBox(height: 40.h),
            BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: (state is BookingCreating || state is BookingRefreshing || !_isFormValid)
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            final room = context.findAncestorWidgetOfExactType<BookingPage>()!.room;
                            final dateStr = '${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2,'0')}-${_selectedDate!.day.toString().padLeft(2,'0')}';
                            final startStr = '${_startTime!.hour.toString().padLeft(2,'0')}:${_startTime!.minute.toString().padLeft(2,'0')}';
                            final endStr = '${_endTime!.hour.toString().padLeft(2,'0')}:${_endTime!.minute.toString().padLeft(2,'0')}';

                            final newBooking = Booking(
                              roomId: room.id,
                              date: dateStr,
                              startTime: startStr,
                              endTime: endStr,
                              userName: _userName!,
                            );

                            context.read<BookingCubit>().createBooking(newBooking);
                          }
                        },
                    child: (state is BookingRefreshing || state is BookingCreating)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 22.w, width: 22.w, child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)),
                            SizedBox(width: 12.w),
                            Text(
                              state is BookingRefreshing ? 'Checking availability...' : 'Confirming...',
                              style: TextStyle(fontSize: 16.sp, color: Colors.white),
                            ),
                          ],
                        )
                      : Text('Confirm Reservation', style: TextStyle(fontSize: 18.sp)),
                  ),
                ).animate().fadeIn(duration: 400.ms, delay: 300.ms).slideY(begin: 0.1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
