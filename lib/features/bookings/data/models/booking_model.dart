import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/booking.dart';

part 'booking_model.g.dart';

@JsonSerializable(includeIfNull: false)
class BookingModel extends Booking {
  BookingModel({
    super.id,
    @JsonKey(name: 'room_id') required super.roomId,
    required super.date,
    @JsonKey(name: 'start_time') required super.startTime,
    @JsonKey(name: 'end_time') required super.endTime,
    @JsonKey(name: 'user_name') required super.userName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => 
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}
