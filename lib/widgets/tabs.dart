import 'package:flutter/material.dart';
import 'package:stepper/widgets/vertical_stepper.dart';

class TabStepper extends StatefulWidget {
  const TabStepper({super.key});

  @override
  State<TabStepper> createState() => _TabStepperState();
}

class _TabStepperState extends State<TabStepper>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController?.addListener(updateIndex);
  }

  @override
  void dispose() {
    _tabController?.removeListener(updateIndex);
    _tabController?.dispose();
    super.dispose();
  }

  void updateIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Cancellation',
            ),
            Tab(
              text: 'Fare Details',
            ),
          ],
        ),
        // TabBarView(controller: _tabController, children: [
        IndexedStack(
          index: _tabController?.index,
          children: [
            VerticalStepper(timings: const [
              "Till 11th Jun'23, 02:00 PM",
              "From 11th Jun'23 02:00 PM, till 14th Jun'23, 02:00 PM",
            ], charges: const [
              "\$0",
              "100% of the booking amount will be charged",
            ]),
            VerticalStepper(timings: const [
              "Till 11th Jun'23, 02:00 PM",
              "checking 2nd step",
              "checking 3rd step",
              "From 11th Jun'23 02:00 PM, till 14th Jun'23, 02:00 PM",
            ], charges: const [
              "\$0",
              "checking",
              "checkingtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest",
              "100% of the booking amount will be charged",
            ]),
          ],
        )
        // ]
        // )
      ],
    );
  }
}
