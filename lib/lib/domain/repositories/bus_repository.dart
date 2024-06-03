
import '../entities/bus_model.dart';

abstract class BusRepository{
  Future<BusList> fetchBus();
}