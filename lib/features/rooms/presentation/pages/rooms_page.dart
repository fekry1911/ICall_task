import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injection_container.dart';
import '../cubit/room_cubit.dart';
import '../cubit/room_state.dart';
import '../widgets/room_card.dart';

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RoomCubit>()..fetchRooms(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Spaces'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF8F9FE), Color(0xFFE2E7FE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: BlocBuilder<RoomCubit, RoomState>(
              builder: (context, state) {
                if (state is RoomLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RoomLoaded) {
                  final rooms = state.rooms;
                  if (rooms.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.meeting_room_outlined, size: 64.w, color: Colors.grey.shade400),
                          SizedBox(height: 16.h),
                          Text('No rooms available.', style: TextStyle(color: Colors.grey.shade600, fontSize: 18.sp)),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return RoomCard(room: rooms[index], index: index);
                    },
                  );
                } else if (state is RoomError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Text(
                        state.message, 
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.redAccent, fontSize: 16.sp),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
