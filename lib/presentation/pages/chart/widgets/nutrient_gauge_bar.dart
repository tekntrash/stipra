part of '../chart_page.dart';

class _NutrientGaugeBar extends StatelessWidget {
  final double value;
  const _NutrientGaugeBar({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomRadialGauge(
      axes: [
        RadialGaugeAxis(
          minAngle: -100,
          maxAngle: 100,
          pointers: [
            RadialNeedlePointer(
              value: value,
              thicknessStart: 1,
              thicknessEnd: 3,
              length: 1,
              knobRadiusAbsolute: 0,
              thickness: 2,
            ),
          ],
          segments: [
            RadialGaugeSegment(
              minValue: 0,
              maxValue: 20,
              minAngle: -100,
              maxAngle: -60,
              color: Color.fromARGB(255, 254, 0, 0),
            ),
            RadialGaugeSegment(
              minValue: 20,
              maxValue: 40,
              minAngle: -60,
              maxAngle: -20,
              color: Color.fromARGB(255, 244, 177, 132),
            ),
            RadialGaugeSegment(
              minValue: 40,
              maxValue: 60,
              minAngle: -20,
              maxAngle: 20,
              color: Color.fromARGB(255, 254, 217, 102),
            ),
            RadialGaugeSegment(
              minValue: 60,
              maxValue: 80,
              minAngle: 20,
              maxAngle: 60,
              color: Color.fromARGB(255, 168, 209, 141),
            ),
            RadialGaugeSegment(
              minValue: 80,
              maxValue: 100,
              minAngle: 60,
              maxAngle: 100,
              color: Color.fromARGB(255, 112, 173, 70),
            ),
          ],
          ticks: [],
          maxValue: 100,
          minValue: 0,
        ),
      ],
    );
  }
}
