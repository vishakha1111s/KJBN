




import 'package:equatable/equatable.dart';

import '../../domain/entities/bus_model.dart';

abstract class BusState extends Equatable {

}

class InitialState extends BusState {

  @override
  List<Object?> get props => [];
}

class BusLoadingState extends BusState {
  @override
  List<Object?> get props => [];
}

class BusLoadCompleteState extends BusState {

  BusModel? busModel;
  BusLoadCompleteState({this.busModel});
  @override
  List<Object?> get props => [];
}

class BusErrorState extends BusState {
  String? error;
  BusErrorState({this.error});
  @override
  List<Object?> get props => [];
}
