// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkMovieModelAdapter extends TypeAdapter<BookmarkMovieModel> {
  @override
  final int typeId = 1;

  @override
  BookmarkMovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkMovieModel(
      backdropPath: fields[0] as String?,
      id: fields[1] as int,
      posterPath: fields[2] as String?,
      title: fields[3] as String?,
      voteAverage: fields[4] as double?,
      voteCount: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkMovieModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.backdropPath)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.voteAverage)
      ..writeByte(5)
      ..write(obj.voteCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkMovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
