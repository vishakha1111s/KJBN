class BusResponse {
  List<RouteInfo>? routeInfo;
  Map<String, List<RouteTiming>>? routeTimings;
  String? errors;

  BusResponse({
    this.routeInfo,
    this.routeTimings,
    this.errors,
  });

  factory BusResponse.fromJson(Map<String, dynamic> json) => BusResponse(
        routeInfo: List<RouteInfo>.from(
            json["routeInfo"].map((x) => RouteInfo.fromJson(x))),
        routeTimings: Map.from(json["routeTimings"]).map((k, v) =>
            MapEntry<String, List<RouteTiming>>(k,
                List<RouteTiming>.from(v.map((x) => RouteTiming.fromJson(x))))),
        errors: json["errors"],
      );

  factory BusResponse.withError(String error) =>
      BusResponse(errors: error, routeInfo: [], routeTimings: {});

  Map<String, dynamic> toJson() => {
        "routeInfo": List<dynamic>.from(routeInfo ?? [].map((x) => x.toJson())),
        "routeTimings": Map.from(routeTimings ?? {}).map((k, v) =>
            MapEntry<String, dynamic>(
                k, List<dynamic>.from(v.map((x) => x.toJson())))),
      };
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

  factory RouteInfo.fromJson(Map<String, dynamic> json) => RouteInfo(
        id: json["id"],
        name: json["name"],
        source: json["source"],
        tripDuration: json["tripDuration"],
        destination: json["destination"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "source": source,
        "tripDuration": tripDuration,
        "destination": destination,
        "icon": icon,
      };
}

class RouteTiming {
  int? totalSeats;
  int? available;
  String? tripStartTime;

  RouteTiming({
    this.totalSeats,
    this.available,
    this.tripStartTime,
  });

  factory RouteTiming.fromJson(Map<String, dynamic> json) => RouteTiming(
        totalSeats: json["totalSeats"],
        available: json["available"],
        tripStartTime: json["tripStartTime"],
      );

  Map<String, dynamic> toJson() => {
        "totalSeats": totalSeats,
        "available": available,
        "tripStartTime": tripStartTime,
      };
}
