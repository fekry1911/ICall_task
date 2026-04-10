import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/room.dart';

part 'room_model.g.dart';

@JsonSerializable()
class RoomModel extends Room {
  RoomModel({
    required super.id,
    required super.name,
    required super.capacity,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => 
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
