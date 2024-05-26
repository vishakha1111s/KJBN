import '../../domain/entities/bus_model.dart' as entity;
import '../../domain/repositories/bus_repository.dart';
import '../datasource/bus_local_storage_api_provider.dart';
import '../model/bus_response.dart';

class BusRepositoryImpl extends BusRepository {
  @override
  Future<entity.BusModel> fetchBus() async {
    BusResponse busResponse = GetBusDataSource().getBusesData();
    List<entity.RouteInfo> routeInfo = [];
    Map<String, List<RouteTiming>> routeTiming = {};

    routeInfo = busResponse.routeInfo?.map((route) {
          return entity.RouteInfo(
            id: route.id ?? "",
            name: route.name ?? "",
            source: route.source ?? "",
            tripDuration: route.tripDuration ?? "",
            destination: route.destination ?? "",
            icon: route.icon ?? "",
          );
        }).toList() ??
        [];
    Map<String, List<entity.TimingRoute>> timing = {};

    busResponse.routeTimings?.forEach((key, value) {
      if (value.isNotEmpty) {
        timing[key] = RouteTimeMapper().mapToList(value);
      } else {
        routeTiming[key] = [];
      }
    });

    // Create and return a BusModel
    return entity.BusModel(
      routeInfo: routeInfo,
      routeTimings: timing,
    );
  }
}

//Mapper to convert RouteTiming to TimingRoute
class RouteTimeMapper {
  entity.TimingRoute map(RouteTiming? response) {
    if (response != null) {
      return entity.TimingRoute(
          tripStartTime: response.tripStartTime,
          available: response.available,
          totalSeats: response.totalSeats);
    } else {
      return entity.TimingRoute(
          tripStartTime: null, available: null, totalSeats: null);
    }
  }

  List<entity.TimingRoute> mapToList(List<RouteTiming>? routeTime) {
    return routeTime?.map((e) => map(e))?.toList() ?? [];
  }
}
