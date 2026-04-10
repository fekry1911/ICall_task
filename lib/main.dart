import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/di/injection_container.dart' as di;
import 'features/rooms/presentation/pages/rooms_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Meeting Room Booking',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6B4EE6), 
              primary: const Color(0xFF6B4EE6),
              secondary: const Color(0xFF0ED3A3), 
              surface: const Color(0xFFF8F9FE),
            ),
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              elevation: 0,
              backgroundColor: const Color(0xFFF8F9FE),
              foregroundColor: const Color(0xFF1E1E2D),
              titleTextStyle: GoogleFonts.outfit(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1E2D),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 2,
                shadowColor: const Color(0xFF6B4EE6).withValues(alpha: 0.4),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                backgroundColor: const Color(0xFF6B4EE6),
                foregroundColor: Colors.white,
                textStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            cardTheme: CardThemeData(
              elevation: 8,
              shadowColor: Colors.black.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              color: Colors.white,
            ),
          ),
          home: child,
        );
      },
      child: const RoomsPage(),
    );
  }
}
