class Booking {
  final int? id;
  final int roomId;
  final String date;
  final String startTime;
  final String endTime;
  final String userName;

  Booking({
    this.id,
    required this.roomId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.userName,
  });
}
