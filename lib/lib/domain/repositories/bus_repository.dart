
import '../entities/bus_model.dart';

abstract class BusRepository{
  Future<BusModel> fetchBus();
}