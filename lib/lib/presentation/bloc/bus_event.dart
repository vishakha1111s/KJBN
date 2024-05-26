import 'package:equatable/equatable.dart';

abstract class BusEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadBusEvent extends BusEvent{

  LoadBusEvent();

  @override
  List<Object> get props => []; //add props
}
class ErrorBusEvent extends BusEvent{

  @override
  List<Object> get props => []; //add props
}