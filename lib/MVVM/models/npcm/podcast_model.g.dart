// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PodcastModelAdapter extends TypeAdapter<PodcastModel> {
  @override
  final int typeId = 12;

  @override
  PodcastModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PodcastModel(
      topic: fields[0] as String,
      podcast: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PodcastModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.podcast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PodcastModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
