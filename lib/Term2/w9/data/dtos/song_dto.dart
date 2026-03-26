import '../../model/songs/song.dart';

class SongDto {
  static const String idKey = 'id';
  static const String titleKey = 'name';
  static const String artistIdKey = 'artists';
  static const String durationKey = 'durationMs'; // in ms
  static const String imageUrl = "imageUri";

  static Song fromJson(Map<String, dynamic> json) {
    assert(json[idKey] is String);
    assert(json[titleKey] is String);
    assert(json[artistIdKey] is String);
    assert(json[durationKey] is int);
    assert(json[imageUrl] is String);

    return Song(
      title: json[titleKey],
      artistId: json[artistIdKey],
      duration: Duration(milliseconds: json[durationKey]),
      imageUrl: Uri.parse(json[imageUrl]),
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      titleKey: song.title,
      artistIdKey: song.artistId,
      durationKey: song.duration.inMilliseconds,
      imageUrl: song.imageUrl.toString(),
    };
  }
}
