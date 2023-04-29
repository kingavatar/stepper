// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:stepper/widgets/stepper_circle.dart';

class VerticalStepper extends StatelessWidget {
  final List<String> timings;
  final List<String> charges;
  final List<String> mytimings = List.empty(growable: true);
  final List<String> mycharges = List.empty(growable: true);

  VerticalStepper({super.key, required this.timings, required this.charges});

  @override
  Widget build(BuildContext context) {
    mytimings.addAll(timings);
    mycharges.addAll(charges);
    if (timings.length <= charges.length) {
      mytimings.addAll(List.filled(charges.length - timings.length, ""));
    } else {
      mycharges.addAll(List.filled(timings.length - charges.length, ""));
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cancellation window",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  "Charges",
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: mycharges
                    .asMap()
                    .map((index, value) => MapEntry(
                        index,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StepperIndicators(
                                isLast: index == mycharges.length - 1),
                            Expanded(
                              child: Text(
                                mytimings[index],
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                value,
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        )))
                    .values
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "As per local time at the property",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StepperIndicators extends StatelessWidget {
  final bool isLast;

  const StepperIndicators({super.key, required this.isLast});

  // List<Widget> stepWidgets(int steps) {
  //   List<Widget> res = List.empty(growable: true);
  //   for (int i = 0; i < steps - 1; i++) {
  //     res.add(const StepperCircle(size: 10, color: Colors.green));
  //     res.add(
  //       const SizedBox(
  //         height: 40,
  //         child: VerticalDivider(
  //           color: Colors.green,
  //           thickness: 2,
  //           // width: 5,
  //           indent: 2,
  //           endIndent: 2,
  //         ),
  //       ),
  //     );
  //   }
  //   res.add(const StepperCircle(size: 10, color: Colors.red));
  //   return res;
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isLast ? 0.0 : 4.0, right: 4.0),
      child: isLast
          ? Column(
              children: const [
                SizedBox(
                  height: 20,
                  child: VerticalDivider(
                    color: Colors.green,
                    endIndent: 2,
                    thickness: 2,
                  ),
                ),
                StepperCircle(size: 10, color: Colors.red),
              ],
            )
          : Column(
              children: const [
                StepperCircle(size: 10, color: Colors.green),
                SizedBox(
                  height: 40,
                  child: VerticalDivider(
                    color: Colors.green,
                    thickness: 2,
                    indent: 2,
                    // endIndent: 2,
                  ),
                ),
              ],
            ),
    );
  }
}
