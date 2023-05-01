import 'package:flutter/material.dart';
import 'package:stepper/models/models.dart';
import 'package:stepper/widgets/stepper_circle.dart';

class HorizontalStepper extends StatelessWidget {
  final List<FlightDetail> flightDetails;
  const HorizontalStepper({super.key, required this.flightDetails});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            // spacing: -40,
            children: List.generate(flightDetails.length, (index) {
              final duration = (index != flightDetails.length - 1)
                  ? "${flightDetails[index + 1].departureTime.difference(flightDetails[index].arrivalTime).inHours.toString().padLeft(2, '0')}h ${(flightDetails[index + 1].departureTime.difference(flightDetails[index].arrivalTime).inMinutes % 60).toString().padLeft(2, '0')}m"
                  : "";
              return [
                StepperIndicators(
                    flightDetail: flightDetails[index],
                    firstItem: index != 0,
                    endItem: duration != ""),
                (index != flightDetails.length - 1)
                    ? DashedStepperIndicators(
                        duration: duration,
                        location: flightDetails[index].arrivalName,
                        code: flightDetails[index].arrivalCode,
                      )
                    : const SizedBox(
                        width: 60,
                      ),
              ];
            }).expand((i) => i).toList(),
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 5, startX = 0;
    final paint = Paint()
      ..color = HSLColor.fromColor(Colors.red).withLightness(0.8).toColor()
      ..strokeWidth = 2;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedSeparator extends StatelessWidget {
  final double height;
  final Color color;
  const DashedSeparator(
      {super.key, this.height = 1, this.color = Colors.black});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.maxWidth;
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class StepperIndicators extends StatelessWidget {
  final FlightDetail flightDetail;
  final bool firstItem;
  final bool endItem;
  const StepperIndicators(
      {super.key,
      required this.flightDetail,
      required this.firstItem,
      required this.endItem});

  @override
  Widget build(BuildContext context) {
    final duration =
        flightDetail.arrivalTime.difference(flightDetail.departureTime);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 62),
              Row(
                children: [
                  // const SizedBox(
                  //   width: 60,
                  // ),
                  firstItem && !endItem
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: CustomPaint(
                              painter: DashedLinePainter(),
                            ),
                          ),
                        )
                      : const Spacer(),
                  const StepperCircle(
                    size: 8,
                    color: Colors.red,
                  ),
                  Expanded(
                    // SizedBox(
                    // width: 60,
                    child: Divider(
                      thickness: 2,
                      indent: 2,
                      endIndent: 0,
                      color: HSLColor.fromColor(Colors.blue)
                          .withLightness(0.8)
                          .toColor(),
                    ),
                  ),
                ],
              ),
              Text(
                // "11:45",
                "${flightDetail.departureTime.hour.toString().padLeft(2, '0')}:${flightDetail.departureTime.minute.toString().padLeft(2, '0')}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                // "11th May 2023",
                "${flightDetail.departureTime.day}${flightDetail.departureTime.ordinalSuffix} ${flightDetail.departureTime.monthName} ${flightDetail.departureTime.year}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                // "Bangalore (BLR)",
                "${flightDetail.departureName} (${flightDetail.departureCode})",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                // "Terminal 2",
                flightDetail.departureTerminal,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          // I wanted to avoid using this due to it's heavy computation but it
          // is very tough to handle a case where we may display a large
          // text we would be needing expanded divider for that
          // otherwise we have to set SizedBox width and overflow of text
          // which would not be aesthetically pleasing for horizontal scrollable
          // widget.
          child: IntrinsicWidth(
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundImage: AssetImage("web/favicon.png"),
                            ),
                          ),
                          Text(
                            flightDetail.flightName,
                            style: Theme.of(context).textTheme.titleSmall,
                          )
                        ],
                      ),
                      Text(
                        flightDetail.flightNumber,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      // width: 30,
                      child: Divider(
                        thickness: 2,
                        color: HSLColor.fromColor(Colors.blue)
                            .withLightness(0.8)
                            .toColor(),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      elevation: 0,
                      color: HSLColor.fromColor(Colors.blue)
                          .withLightness(0.92)
                          .toColor(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6.0),
                        child: Text(
                          "${duration.inHours.toString().padLeft(2, '0')}h ${(duration.inMinutes % 60).toString().padLeft(2, '0')}m",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    Expanded(
                      // width: 30,
                      child: Divider(
                        thickness: 2,
                        color: HSLColor.fromColor(Colors.blue)
                            .withLightness(0.8)
                            .toColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 62),
              Row(
                children: [
                  Expanded(
                    // SizedBox(
                    //   width: 60,
                    child: Divider(
                      thickness: 2,
                      endIndent: 2,
                      color: HSLColor.fromColor(Colors.blue)
                          .withLightness(0.8)
                          .toColor(),
                    ),
                  ),
                  const StepperCircle(
                    size: 8,
                    color: Colors.red,
                  ),
                  // const SizedBox(
                  //   width: 60,
                  // ),
                  !firstItem && endItem
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: CustomPaint(
                              painter: DashedLinePainter(),
                            ),
                          ),
                        )
                      : const Spacer(),
                ],
              ),
              Text(
                // "11:45",
                "${flightDetail.arrivalTime.hour.toString().padLeft(2, '0')}:${flightDetail.arrivalTime.minute.toString().padLeft(2, '0')}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                // "11th May 2023",
                "${flightDetail.arrivalTime.day}${flightDetail.arrivalTime.ordinalSuffix} ${flightDetail.arrivalTime.monthName} ${flightDetail.arrivalTime.year}",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                // "Bangalore (BLR)",
                "${flightDetail.arrivalName} (${flightDetail.arrivalCode})",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                // "Terminal 2",
                flightDetail.arrivalCode,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DashedStepperIndicators extends StatelessWidget {
  final String duration;
  final String location;
  final String code;
  const DashedStepperIndicators(
      {super.key,
      required this.duration,
      required this.location,
      required this.code});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                width: 30,
                child: DashedSeparator(
                  height: 2,
                  color: HSLColor.fromColor(Colors.red)
                      .withLightness(0.8)
                      .toColor(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 48,
                child: Column(
                  children: [
                    Text(
                      "Layover in",
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      location,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "($code)",
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    elevation: 0,
                    color: HSLColor.fromColor(Colors.red)
                        .withLightness(0.92)
                        .toColor(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 6.0),
                      child: Text(
                        duration,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SizedBox(
                width: 30,
                child: DashedSeparator(
                  height: 2,
                  color: HSLColor.fromColor(Colors.red)
                      .withLightness(0.8)
                      .toColor(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
