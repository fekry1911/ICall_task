// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
  id: (json['id'] as num?)?.toInt(),
  roomId: (json['room_id'] as num).toInt(),
  date: json['date'] as String,
  startTime: json['start_time'] as String,
  endTime: json['end_time'] as String,
  userName: json['user_name'] as String,
);

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'room_id': instance.roomId,
      'date': instance.date,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'user_name': instance.userName,
    };
