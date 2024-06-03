class BusResponse {
  final String? type;
  final String? id;
  final String? vehicleId;
  final String? naptanId;
  final String? stationName;
  final String? lineId;
  final String? lineName;
  final String? direction;
  final String? destinationNaptanId;
  final String? destinationName;
  final String? timestamp;
  final String? currentLocation;
  final String? towards;
  final String? expectedArrival;
  final String? timeToLive;
  final String? modeName;
  final String? errors;

  BusResponse({
    this.type,
    this.id,
    this.vehicleId,
    this.naptanId,
    this.stationName,
    this.lineId,
    this.lineName,
    this.direction,
    this.destinationNaptanId,
    this.destinationName,
    this.timestamp,
    this.currentLocation,
    this.towards,
    this.expectedArrival,
    this.timeToLive,
    this.modeName,
    this.errors,
  });

  factory BusResponse.fromJson(Map<String, dynamic> json) => BusResponse(
    type: json['\$type'],
    id: json['id'],
    vehicleId: json['vehicleId'],
    naptanId: json['naptanId'],
    stationName: json['stationName'],
    lineId: json['lineId'],
    lineName: json['lineName'],
    direction: json['direction'],
    destinationNaptanId: json['destinationNaptanId'],
    destinationName: json['destinationName'],
    timestamp: json['timestamp'],
    currentLocation: json['currentLocation'],
    towards: json['towards'],
    expectedArrival: json['expectedArrival'],
    timeToLive: json['timeToLive'],
    modeName: json['modeName'],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    '\$type': type,
    'id': id,
    'vehicleId': vehicleId,
    'naptanId': naptanId,
    'stationName': stationName,
    'lineId': lineId,
    'lineName': lineName,
    'direction': direction,
    'destinationNaptanId': destinationNaptanId,
    'destinationName': destinationName,
    'timestamp': timestamp,
    'currentLocation': currentLocation,
    'towards': towards,
    'expectedArrival': expectedArrival,
    'timeToLive': timeToLive,
    'modeName': modeName,
  };

  factory BusResponse.withError(String error) =>
      BusResponse(errors: error);
}