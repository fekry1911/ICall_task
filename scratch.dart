void main() {
  final currentBookings = [
    Booking(date: '2026-04-11', startTime: '10:00', endTime: '11:00')
  ];

  DateTime _parseDateTime(String date, String time) {
    try {
      final dateParts = date.split('-');
      final timeParts = time.split(':');
      final dayStr = dateParts[2].length > 2 ? dateParts[2].substring(0, 2) : dateParts[2];
      
      return DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dayStr),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
    } catch (e) {
      print("PARSE ERROR: $e");
      return DateTime.now();
    }
  }

  bool _hasTimeOverlap(DateTime newStart, DateTime newEnd) {
    for (final existing in currentBookings) {
      final existingStart = _parseDateTime(existing.date, existing.startTime);
      final existingEnd = _parseDateTime(existing.date, existing.endTime);

      print("Existing: $existingStart to $existingEnd");
      print("New:      $newStart to $newEnd");

      if (newStart.isBefore(existingEnd) && newEnd.isAfter(existingStart)) {
        return true;
      }
    }
    return false;
  }

  final newStart = _parseDateTime('2026-04-11', '10:00');
  final newEnd = _parseDateTime('2026-04-11', '11:00');

  print("Overlap? ${_hasTimeOverlap(newStart, newEnd)}");
}

class Booking {
  String date;
  String startTime;
  String endTime;
  Booking({required this.date, required this.startTime, required this.endTime});
}
