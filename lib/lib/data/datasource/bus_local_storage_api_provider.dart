import '../../utils/core.dart';
import '../model/bus_response.dart';

class GetBusDataSource {

  // Calling Api
  Future<List<BusResponse>> getBusesData() async {
    try {
      var response = await CoreApplication().dio.get("/Vehicle/200/Arrivals",
          queryParameters: {

            "apiKey": "11d4cd5e95b54423901d72b8167fe73a"
          });
      print("LL, ${response.data}");
      List<dynamic> data = response.data;


      return data.map((busJson) => BusResponse.fromJson(busJson)).toList();

    } on Exception catch (e) {
      AppLogger.log("Bus - Dio Error: $e");
      return [BusResponse.withError(e.toString())];
    } on Error catch (e) {
      AppLogger.log("Bus - Error: $e");
     return [BusResponse.withError(e.toString())];
    }
  }
}