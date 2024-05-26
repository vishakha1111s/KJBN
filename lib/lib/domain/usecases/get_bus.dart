

import '../entities/bus_model.dart';
import '../repositories/bus_repository.dart';

class GetBus {
  final BusRepository repository;

  GetBus(this.repository);

  Future<BusModel> call() async {
    return repository.fetchBus();
  }
}
