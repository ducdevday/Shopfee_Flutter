

import 'package:geolocator/geolocator.dart';
import 'package:shopfee/data/models/place.dart';
import 'package:shopfee/data/models/place_auto_complete.dart';
import 'package:shopfee/data/models/place_search.dart';

abstract class PlaceRepositoryBase{
  Future<List<PlaceAutoComplete>?> getPlacesAutoComplete(String searchInput);
  Future<Place?> getPlace(String placeId);
  Future<List<PlaceSearch>?> getAllPlaceSearch(String queryInput);
  Future<List<PlaceSearch>?> getAllPlaceDefault(double lat, double lng);

}