import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled2/lib/domain/entities/bus_model.dart';
import 'package:untitled2/lib/presentation/bloc/bus_bloc.dart';
import 'package:untitled2/lib/presentation/bloc/bus_state.dart';
import 'package:untitled2/lib/presentation/bus_page.dart';


// Mock class for the BusBloc
class MockBusBloc extends Mock implements BusBloc {}

void main() {
  group('BusPage Widget Tests', () {
    late BusBloc mockBusBloc;

    setUp(() {
      mockBusBloc = MockBusBloc();
    });

    testWidgets('Loading state displays CircularProgressIndicator',
            (WidgetTester tester) async {
          when(mockBusBloc.state).thenReturn(BusLoadingState());

          await tester.pumpWidget(const MaterialApp(
            home: BusPage(),
          ));

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        });

    // Add more tests for other states (e.g., BusErrorState, BusLoadCompleteState)
  });

  group('BusRouteCard Widget Tests', () {
    testWidgets('Displays correct route info', (WidgetTester tester) async {
      // Mock BusLoadCompleteState
      final state = BusLoadCompleteState(
        busModel: BusModel(
          routeInfo: [
            RouteInfo(id: '1', name: 'Route 1', source: 'Source 1', destination: 'Destination 1', tripDuration: '2 hours'),
          ],
          routeTimings: {},
        ),
      );

      await tester.pumpWidget(MaterialApp(
        home: BusRouteCard(state: state, index: 0),
      ));

      // Verify that the route name is displayed correctly
      expect(find.text('Route 1'), findsOneWidget);

      // Add more tests for other route info (source, destination, tripDuration, etc.)
    });
  });
}
