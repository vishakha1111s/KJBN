class BusModel {
  List<RouteInfo>? routeInfo;
  Map<String, List<TimingRoute>>? routeTimings;

  BusModel({
    this.routeInfo,
    this.routeTimings,
  });
}

class TimingRoute {
  int? totalSeats;
  int? available;
  String? tripStartTime;

  TimingRoute({
    this.totalSeats,
    this.available,
    this.tripStartTime,
  });
}

class RouteInfo {
  String? id;
  String? name;
  String? source;
  String? tripDuration;
  String? destination;
  String? icon;

  RouteInfo({
    this.id,
    this.name,
    this.source,
    this.tripDuration,
    this.destination,
    this.icon,
  });
}
