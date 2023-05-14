// To parse this JSON data, do
//
//     final airoport = airoportFromJson(jsonString);

import 'dart:convert';

Airoport airoportFromJson(String str) => Airoport.fromJson(json.decode(str));

class Airoport {
  final String name;
  final List<Parking> parking;

  Airoport({
    required this.name,
    required this.parking,
  });

  factory Airoport.fromJson(Map<String, dynamic> json) => Airoport(
        name: json["name"],
        parking:
            List<Parking>.from(json["parking"].map((x) => Parking.fromJson(x))),
      );
}

class Parking {
  final String name;
  final double price;
  final String id;
  final bool saved;
  final Location location;
  final List<Floor> floors;

  Parking({
    required this.name,
    required this.price,
    required this.location,
    required this.floors,
    required this.id,
    required this.saved,
  });

  factory Parking.fromJson(Map<String, dynamic> json) => Parking(
        name: json["name"],
        price: json["price"],
        id: json["id"],
        saved: json["saved"],
        location: Location.fromJson(json["location"]),
        floors: List<Floor>.from(json["floors"].map((x) => Floor.fromJson(x))),
      );
}

class Floor {
  final String name;
  final List<Place> places;

  Floor({
    required this.name,
    required this.places,
  });

  factory Floor.fromJson(Map<String, dynamic> json) => Floor(
        name: json["name"],
        places: List<Place>.from(json["places"].map((x) => Place.fromJson(x))),
      );
}

class Place {
  final String name;
  final bool state;

  Place({
    required this.name,
    required this.state,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        name: json["name"],
        state: json["state"],
      );
}

class Location {
  final double lat;
  final double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );
}