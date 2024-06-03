import '../../domain/entities/bus_model.dart' as entity;
import '../../domain/repositories/bus_repository.dart';
import '../datasource/bus_local_storage_api_provider.dart';
import '../model/bus_response.dart';

class BusRepositoryImpl extends BusRepository {
  @override
  Future<entity.BusList> fetchBus() async {
    List<BusResponse> busResponse = await GetBusDataSource().getBusesData();
    String? currentLocation,
        expectedArrival,
        timeToLive,
        stationName,
        timestamp,
        vehicleId,
        lineName,
        direction,
        destinationName,
        towards;

    List<entity.BusModel> busmodel = [];

    for (int i = 0; i < (busResponse.length); i++) {
      vehicleId = busResponse[i].vehicleId;
      lineName = busResponse[i].lineName;
      direction = busResponse[i].direction;
      stationName = busResponse[i].stationName;
      timestamp = busResponse[i].timestamp;
      destinationName = busResponse[i].destinationName;
      currentLocation = busResponse[i].currentLocation;
      expectedArrival = busResponse[i].expectedArrival;
      timeToLive = busResponse[i].timeToLive;
      towards = busResponse[i].towards;
      busmodel.add(entity.BusModel(
        vehicleId: vehicleId,
        lineName: lineName,
        direction: direction,
        stationName: stationName,
        timestamp: timestamp,
        destinationName: destinationName,
        currentLocation: currentLocation,
        expectedArrival: expectedArrival,
        timeToLive: timeToLive,
        towards: towards,
      ));
    }

    return entity.BusList(
      busmodel: busmodel
    );
  }
}