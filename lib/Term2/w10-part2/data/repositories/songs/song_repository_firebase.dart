import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  List<Song>? _cachedSongs;

  final Uri songsUri = Uri.https(
    'https://week10-part2-default-rtdb.asia-southeast1.firebasedatabase.app',
    '/songs.json',
  );

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {
    if (!forceFetch && _cachedSongs != null) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      Map<String, dynamic> songJson = json.decode(response.body);

      List<Song> result = [];
      for (final entry in songJson.entries) {
        result.add(SongDto.fromJson(entry.key, entry.value));
      }
      _cachedSongs = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}

  @override
  Future<void> likeSong(Song song) async {
    final Uri url = Uri.https(
      'https://week10-part2-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/${song.id}.json',
    );

    try {
      final newLikes = (song.likes ?? 0) + 1;
      final response = await http.patch(
        url,
        body: jsonEncode({'likes': newLikes}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update likes');
      }
    } catch (e) {
      throw Exception('Failed to like the song: $e');
    }
  }
  void clearCache() {
    _cachedSongs = null;
  }
}
