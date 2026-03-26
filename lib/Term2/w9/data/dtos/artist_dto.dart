import 'package:blabla/Term2/w9/model/artists/artist.dart';

class ArtistDto {
  static const idKey = "id";
  static const genre = "genre";
  static const imageUrl = "imageUrl";
  static const name = "name";

  static Artist fromJson(Map<String, dynamic> json) {
    return Artist(
      name: json[name],
      genre: json[genre],
      imageUrl: Uri.parse(json[imageUrl]),
    );
  }
}
