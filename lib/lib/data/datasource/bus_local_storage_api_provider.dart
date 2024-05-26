
import 'dart:convert';

import '../../utils/constants.dart';
import '../model/bus_response.dart';


class GetBusDataSource {
  var errorStr = errorMsg;
  BusResponse getBusesData() {
    var response = """{
        "routeInfo": [
          {
            "id": "r002",
            "name": "k-12",
            "source": "Yashwantpur",
            "tripDuration": "2hrs",
            "destination": "Marathahalli",
            "icon": "http://"
          },
          {
            "id": "r003",
            "name": "k-11",
            "source": "Koramangala",
            "tripDuration": "45 min",
            "destination": "Bomanhalli",
            "icon": "http://"
          },
          {
            "id": "r004",
            "name": "k-14",
            "source": "E City",
            "tripDuration": "1hrs",
            "destination": "Silk Board",
            "icon": "http://"
          },
          {
            "id": "r001",
            "name": "R-1",
            "source": "Marathahalli",
            "tripDuration": "2hrs",
            "destination": "E City",
            "icon": "http://"
          },
          {
            "id": "r005",
            "name": "G-12",
            "tripDuration": "2hrs",
            "source": "Koramangala",
            "destination": "E City",
            "icon": "http://"
          }
        ],
        "routeTimings": {
          "r002": [
            {
              "totalSeats": 13,
              "available": 0,
              "tripStartTime": "18:40"
            },
            {
              "totalSeats": 13,
              "available": 0,
              "tripStartTime": "18:48"
            },
            {
              "totalSeats": 13,
              "available": 1,
              "tripStartTime": "19:05"
            }
          ],
          "r005": [
            {
              "totalSeats": 13,
              "available": 5,
              "tripStartTime": "19:10"
            },
            {
              "totalSeats": 13,
              "available": 0,
              "tripStartTime": "19:00"
            },
            {
              "totalSeats": 13,
              "available": 1,
              "tripStartTime": "19:05"
            }
          ],
          "r001": [],
          "r004": [
            {
              "totalSeats": 13,
              "available": 5,
              "tripStartTime": "14:55"
            },
            {
              "totalSeats": 13,
              "available": 0,
              "tripStartTime": "15:00"
            },
            {
              "totalSeats": 13,
              "available": 1,
              "tripStartTime": "15:05"
            }
          ],
          "r003": [
            {
              "totalSeats": 12,
              "available": 10,
              "tripStartTime": "15:55"
            },
            {
              "totalSeats": 12,
              "available": 9,
              "tripStartTime": "20:00"
            },
            {
              "totalSeats": 12,
              "available": 1,
              "tripStartTime": "19:05"
            }
          ]
        }


    }""";
     Map<String, dynamic> jsonMap= json.decode(response.toString());
    return BusResponse.fromJson(jsonMap);
  }
}
