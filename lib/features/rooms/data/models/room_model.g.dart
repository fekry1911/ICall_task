// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  capacity: (json['capacity'] as num).toInt(),
);

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'capacity': instance.capacity,
};
