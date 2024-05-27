import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled2/lib/presentation/widget/bus_common_widgets.dart';
import 'package:untitled2/lib/utils/core.dart';

import '../data/repositories/bus_repository.dart';
import '../domain/usecases/get_bus.dart';
import '../utils/calculations.dart';
import '../utils/constants.dart';
import 'bloc/bus_bloc.dart';
import 'bloc/bus_event.dart';
import 'bloc/bus_state.dart';

class BusPage extends StatefulWidget {
  const BusPage({Key? key}) : super(key: key);

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  final BusBloc _newsBloc =
      BusBloc(InitialState(), GetBus(BusRepositoryImpl()));

  @override
  void initState() {
    _newsBloc.add(LoadBusEvent());
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return;
      }

    } catch (e) {
      AppLogger.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _newsBloc,
      buildWhen: (previousState, state) {
        return (state is BusLoadCompleteState ||
            state is BusLoadingState ||
            state is BusErrorState);
      },
      builder: (BuildContext context, state) {
        if (state is BusLoadingState) {
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is BusErrorState) {
          return Center(
              child: new Text(
            state.error ?? errorMsg,
            textAlign: TextAlign.start,
          ));
        } else if (state is BusLoadCompleteState) {
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  "$routes",
                ),
              ),
            ),
            body: ListView.builder(
              itemCount: state.busModel?.routeInfo?.length ?? 0,
              itemBuilder: (context, index) {
                return BusRouteCard(state: state, index: index);
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class BusRouteCard extends StatelessWidget {
  final BusLoadCompleteState state;
  final int index;

  BusRouteCard({required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    final routeInfo = state.busModel?.routeInfo?[index];
    final routeTimings = state.busModel?.routeTimings?[routeInfo?.id ?? ''];
    return Card(
      margin: EdgeInsets.all(10),
      elevation: padding_4,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(routeInfo?.icon ?? ''),
            ),
            title: Text(
              routeInfo?.name ?? '',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            subtitle: Text('$busId ${routeInfo?.id ?? ''}'),
          ),
          Padding(
            padding: const EdgeInsets.all(font_16),
            child: Column(
              children: <Widget>[
                commonRowWidget(Icons.location_on,
                    '$source ${routeInfo?.source ?? ""}', Colors.green),
                commonRowWidget(
                    Icons.location_on,
                    '$destination ${routeInfo?.destination ?? ""}',
                    Colors.yellow),
                commonRowWidget(
                    Icons.av_timer,
                    'Trip Duration: ${routeInfo?.tripDuration ?? ""}',
                    Colors.red),
                for (final timing in routeTimings ?? [])
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Visibility(
                      visible: ((parseTime(timing.tripStartTime).hour <
                              DateTime.now().hour) ||
                          ((parseTime(timing.tripStartTime).hour <
                                  DateTime.now().hour) &&
                              (parseTime(timing.tripStartTime).minute <
                                  DateTime.now().minute))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonRowWidget(
                              Icons.access_time,
                              'Trip Start Time: ${timing.tripStartTime ?? ""}',
                              Colors.red),
                          commonRowWidget(
                              Icons.event_seat,
                              'Available Seats: ${timing.available ?? 0}',
                              Colors.green),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
