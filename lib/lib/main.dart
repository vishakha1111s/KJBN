import 'package:flutter/material.dart';
import 'package:untitled2/lib/presentation/bus_page.dart';
import 'package:untitled2/lib/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          fontFamily: 'Georgia',
          //text styling
          textTheme: const TextTheme(
            displayLarge:
                TextStyle(fontSize: font_20, fontWeight: FontWeight.bold),
            displayMedium:
                TextStyle(fontSize: font_16, fontStyle: FontStyle.normal),
            displaySmall: TextStyle(fontSize: font_12, fontFamily: 'Hind'),
          )),
      home: const BusPage(),
    );
  }
}
