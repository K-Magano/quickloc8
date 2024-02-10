/*Overall, this class serves as a model for representing vehicle coordinates. 
It provides functionality for initializing objects with coordinate data and parsing coordinate data from JSON format.*/

class VehicleCoordinate {
  String? heading;
  double? latitude;
  double? longitude;

  VehicleCoordinate({
    this.heading,
    this.latitude,
    this.longitude,
  });

  VehicleCoordinate.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    latitude = double.parse(json['latitude']);
    longitude = double.parse(json['longitude']);
  }
}
