class BusList{
  final List<BusModel> busmodel;
  BusList({required this.busmodel});
}
class BusModel {
  final String? type;
  final int? id;
  final int? operationType;
  final String? vehicleId;
  final String? naptanId;
  final String? stationName;
  final String? lineId;
  final String? lineName;
  final String? platformName;
  final String? direction;
  final String? bearing;
  final String? destinationNaptanId;
  final String? destinationName;
  final String? timestamp;
  final int? timeToStation;
  final String? currentLocation;
  final String? towards;
  final String? expectedArrival;
  final String? timeToLive;
  final String? modeName;
  final String? errors;

  BusModel({
    this.type,
    this.id,
    this.operationType,
    this.vehicleId,
    this.naptanId,
    this.stationName,
    this.lineId,
    this.lineName,
    this.platformName,
    this.direction,
    this.bearing,
    this.destinationNaptanId,
    this.destinationName,
    this.timestamp,
    this.timeToStation,
    this.currentLocation,
    this.towards,
    this.expectedArrival,
    this.timeToLive,
    this.modeName,
    this.errors,
  });

}

