// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyStepper extends StatelessWidget {
  final List<String> timings;
  final List<String> charges;

  const MyStepper({super.key, required this.timings, required this.charges});

  @override
  Widget build(BuildContext context) {
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
              child: Row(
                children: [
                  StepperIndicators(numSteps: charges.length),
                  Flexible(
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: charges
                          .asMap()
                          .map((index, value) => MapEntry(
                              index,
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        timings[index],
                                        style:
                                            Theme.of(context).textTheme.labelSmall,
                                      ),
                                    ),
                                    Flexible(
                                      child: Text(
                                        value,
                                        style:
                                            Theme.of(context).textTheme.labelSmall,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              )))
                          .values
                          .toList(),
                    ),
                  ),
                ],
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

class StepperCircle extends StatelessWidget {
  final double size;
  final Color color;

  const StepperCircle({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 4,
        )
      ]),
    );
  }
}


class StepperIndicators extends StatelessWidget {
  final int numSteps;

  const StepperIndicators({super.key, required this.numSteps});

  List<Widget> stepWidgets(int steps) {
    List<Widget> res = List.empty(growable: true);
    for (int i = 0; i < steps - 1; i++) {
      res.add(const StepperCircle(size: 10, color: Colors.green));
      res.add(
        const SizedBox(
          height: 40,
          child: VerticalDivider(
            color: Colors.green,
            thickness: 2,
            // width: 5,
            indent: 2,
            endIndent: 2,
          ),
        ),
      );
    }
    res.add(const StepperCircle(size: 10, color: Colors.red));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: stepWidgets(numSteps));
  }
}
