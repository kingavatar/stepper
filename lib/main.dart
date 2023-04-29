import 'package:flutter/material.dart';
import 'package:stepper/models/models.dart';
import 'package:stepper/widgets/vertical_stepper.dart';
import 'package:stepper/widgets/horizontal_stepper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stepper',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MyHomePage(title: 'Stepper Widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<FlightDetail> flightDetails = [
    FlightDetail(
      flightName: "Air Asia",
      flightNumber: "I5-1562",
      departureName: "Bangalore",
      departureCode: "BLR",
      departureTerminal: "Terminal 2",
      arrivalName: "Bhubaneshwar",
      arrivalCode: "BBI",
      arrivalTerminal: "Terminal 1",
      departureTime: DateTime(2023, 5, 11, 11, 55),
      arrivalTime: DateTime(2023, 5, 11, 13, 55),
    ),
    FlightDetail(
      flightName: "Air Asia",
      flightNumber: "I5-766",
      departureName: "Bhubaneshwar",
      departureCode: "BBI",
      departureTerminal: "Terminal 1",
      arrivalName: "Bhubaneshwar",
      arrivalCode: "BBI",
      arrivalTerminal: "Terminal 1",
      departureTime: DateTime(2023, 5, 11, 18, 25),
      arrivalTime: DateTime(2023, 5, 11, 20, 45),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            VerticalStepper(
              timings: const [
                "Till 11th Jun'23, 02:00 PM",
                "checking 2nd step",
                "checking 3rd step",
                "From 11th Jun'23 02:00 PM, till 14th Jun'23, 02:00 PM",
              ],
              charges: const [
                "\$0",
                "checking",
                "checking",
                "100% of the booking amount will be charged",
              ],
            ),
            HorizontalStepper(
              flightDetails: flightDetails,
            ),
          ],
        )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
