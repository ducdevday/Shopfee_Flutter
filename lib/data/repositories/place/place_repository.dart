import 'package:shopfee/data/models/place.dart';
import 'package:shopfee/data/models/place_auto_complete.dart';
import 'package:shopfee/data/models/place_search.dart';
import 'package:shopfee/data/repositories/place/place_repository_base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlaceRepository extends PlaceRepositoryBase {
  final String key = "AIzaSyCSg1rUNMFzffBr5SrTQwyiYQY6vaVeoqY";
  final String types = "geocode";
  final String language = "vi-VN";
  final String region = "VN";

  PlaceRepository();

  @override
  Future<List<PlaceAutoComplete>> getPlacesAutoComplete(
      String searchInput) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&language=$language&region=$region&types=$types&key=$key";
    var response = await http.get(Uri.parse(url));
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var result = jsonResponse['predictions'] as List;

    return result.map((e) => PlaceAutoComplete.fromJson(e)).toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/details/json?&place_id=$placeId&key=$key";
    var response = await http.get(Uri.parse(url));
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var result = jsonResponse["result"] as Map<String, dynamic>;
    return Place.fromJson(result);
  }

  @override
  Future<List<PlaceSearch>?> getAllPlaceSearch(String queryString) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$queryString&language=$language&region=$region&key=$key";
    var response = await http.get(Uri.parse(url));
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var result = jsonResponse['results'] as List;
    return result.map((e) => PlaceSearch.fromMap(e)).toList();
  }

  @override
  Future<List<PlaceSearch>?> getAllPlaceDefault(double lat, double lng) async {
    final String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&language=$language&region=$region&key=$key";
    var response = await http.get(Uri.parse(url));
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var result = jsonResponse['results'] as List;
    return result.map((e) => PlaceSearch.fromMap(e)).toList();
  }
}
